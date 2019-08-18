module Main exposing (main)

import Browser
import Character
import Game
import Geometry
import Html exposing (Html, text)
import Html.Attributes exposing (class, style)
import Keyboard
import Pokemon exposing (Pokemon(..))
import Time
import World
import Task
import Process


-- ⛩


type alias Flags =
    ()


{-| The entry point, the main gate, to the Elm world.

The program.

This is where all the different parts of your application come together.
This "gate" comes in all kinds of shapes:
<https://package.elm-lang.org/packages/elm/browser/latest/Browser>
We'll start with the most simple kind.

Parts:

  - Flags, things you want to bring through the gate.
  - Model, what does our Elm world/app look like.
  - Msg, what can happen in our Elm world/app.
    (msg is short for message)

More advanced parts:

  - Subscription, listen to changes happening in the Outside world.
  - Command, make something happen on the side (ie. asynchronously).

-}
main : Program Flags Model Msg
main =
    Browser.element
        { init = init, subscriptions = subscriptions, update = update, view = view }


-- 🌳


type alias Model =
    { characterPosition : Geometry.Coordinates
    , characterWalkCycle : Character.WalkCycle
    , shownPokemon : Maybe Pokemon
    , caughtPokemon : Maybe Pokemon
    , passedTime : Time.Posix
    , options : Game.Options
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { characterPosition = { x = 1, y = 1 }
      , characterWalkCycle = Character.initialWalkCycle Character.Down
      , shownPokemon = Nothing
      , caughtPokemon = Nothing
      , passedTime = Time.millisToPosix 0
      , options = Game.defaultOptions
      }
    , Cmd.none
    )


-- 📣


type Msg
    = ArrowKeyPressed Keyboard.ArrowKey
    | SetCurrentTime Time.Posix
    | CatchPokemon
    | CaughtPokemon
    | Ignore


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        -- TELEPORT!
        ArrowKeyPressed key ->
            ( { model
                | characterPosition = Character.move (convertArrowKey key) model.characterPosition
                , characterWalkCycle = Character.walk (convertArrowKey key) model.characterWalkCycle
                , shownPokemon = showPokemon model
              }
            , Cmd.none
            )

        -- CURRENT TIME
        SetCurrentTime time ->
            ( { model | passedTime = time }, Cmd.none )

        -- CATCH POKEMON
        CatchPokemon ->
            ( { model | options = {cacheBuster = 0, showPokeball = True } }, triggerCaughtPokemon )

        -- POKEMON CAUGHT
        CaughtPokemon ->
            ( { model | caughtPokemon = model.shownPokemon, shownPokemon = Nothing, options = {cacheBuster = 1, showPokeball = False } }, Cmd.none )

        -- IGNORE
        Ignore ->
            ( model, Cmd.none )


convertArrowKey : Keyboard.ArrowKey -> Character.Direction
convertArrowKey key =
    case key of
        -- UP
        Keyboard.ArrowUp ->
            Character.Up

        -- DOWN
        Keyboard.ArrowDown ->
            Character.Down

        -- LEFT
        Keyboard.ArrowLeft ->
            Character.Left

        -- RIGHT
        Keyboard.ArrowRight ->
            Character.Right


showPokemon : Model -> Maybe Pokemon
showPokemon model =
    if World.anyHighGrassAt model.characterPosition then
        Pokemon.basedOnTime model.passedTime

    else
        Nothing


triggerCaughtPokemon : Cmd Msg
triggerCaughtPokemon =
  Task.perform (\_ -> CaughtPokemon) (Process.sleep Pokemon.ballAnimationDuration)



-- 📰


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Keyboard.onArrowKeyDown ArrowKeyPressed
        , Time.every 500 SetCurrentTime
        ]


-- 🗺


view : Model -> Html Msg
view model =
    Game.render5 model.characterPosition model.characterWalkCycle model.shownPokemon CatchPokemon model.options
