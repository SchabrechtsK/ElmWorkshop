module Main exposing (main)

import Browser
import Browser.Events
import Character exposing (Direction(..), WalkCycle)
import Game
import Geometry exposing (Coordinates)
import Keyboard exposing (ArrowKey(..))
import Pokemon exposing (Pokemon(..))
import Process
import Task
import Time
import World



-- ⛩


type alias Flags =
    ()


main : Program Flags Model Msg
main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- 🌳


type alias Model =
    { caughtPokemon : List Pokemon
    , characterPosition : Coordinates
    , characterWalkCycle : WalkCycle
    , currentTime : Time.Posix
    , showPokeball : Bool
    , shownPokemon : Maybe Pokemon
    }


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( --
      { caughtPokemon = []
      , characterPosition = { x = 8, y = 7 }
      , characterWalkCycle = Character.initialWalkCycle Down
      , currentTime = Time.millisToPosix 0
      , showPokeball = False
      , shownPokemon = Nothing
      }
      --
    , Cmd.none
    )



-- 📣


type Msg
    = CatchPokemon
    | CaughtPokemon
    | KeyDown Keyboard.ArrowKey
    | UpdateCurrentTime Time.Posix


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( ------------------------------------------------------------------------
      -- Model
      ------------------------------------------------------------------------
      case msg of
        CatchPokemon ->
            -- Start Pokéball animation.
            { model | showPokeball = True }

        CaughtPokemon ->
            -- Add shown Pokémon to collection,
            -- and no longer show Pokéball and Pokémon.
            { model
                | caughtPokemon =
                    case model.shownPokemon of
                        Just pokemon ->
                            pokemon :: model.caughtPokemon

                        Nothing ->
                            model.caughtPokemon
                , showPokeball = False
                , shownPokemon = Nothing
            }

        KeyDown key ->
            -- Only move the character if we don't show the Pokémon screen.
            case model.shownPokemon of
                Just _ ->
                    model

                Nothing ->
                    model
                        |> moveAndWalk (arrowKeyToDirection key)
                        |> checkForPokemon model.currentTime

        UpdateCurrentTime time ->
            { model | currentTime = time }
      ------------------------------------------------------------------------
      -- Command
      ------------------------------------------------------------------------
    , case msg of
        CatchPokemon ->
            -- Wait for the animation to finish.
            -- and then send the `CaughtPokemon` message.
            Pokemon.ballAnimationDuration
                |> Process.sleep
                |> Task.perform (\_ -> CaughtPokemon)

        _ ->
            Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        [ Keyboard.onArrowKeyDown KeyDown
        , Time.every 500 UpdateCurrentTime
        ]



-- 📣  ~  Helpers


arrowKeyToDirection : ArrowKey -> Direction
arrowKeyToDirection key =
    case key of
        ArrowUp ->
            Up

        ArrowDown ->
            Down

        ArrowLeft ->
            Left

        ArrowRight ->
            Right


checkForPokemon : Time.Posix -> Model -> Model
checkForPokemon time model =
    if World.anyHighGrassAt model.characterPosition then
        { model | shownPokemon = Pokemon.basedOnTime time }

    else
        model


moveAndWalk : Direction -> Model -> Model
moveAndWalk direction model =
    { model
        | characterPosition = Character.move direction model.characterPosition
        , characterWalkCycle = Character.walk direction model.characterWalkCycle
    }



-- 🏞


view : Model -> Browser.Document Msg
view model =
    { title = "Pokémon"
    , body =
        [ Game.render5
            model.characterPosition
            model.characterWalkCycle
            model.shownPokemon
            CatchPokemon
            { cacheBuster = List.length model.caughtPokemon
            , showPokeball = model.showPokeball
            }
        ]
    }
