module Game exposing (Options, defaultOptions, render0, render1, render2, render3, render4, render5)

{-| This module is responsible for rendering the game.
You can build this up in steps.
It progresses from `render0` to `render5`.

@docs Options, defaultOptions, render0, render1, render2, render3, render4, render5

-}

import Character exposing (Direction(..), WalkCycle)
import Geometry exposing (Coordinates)
import Html exposing (Html, a, br, div, node, span, text)
import Html.Attributes exposing (attribute, style)
import Html.Events exposing (onClick)
import Pokemon exposing (Pokemon)
import World



-- 🏞


{-| `0`.
-}
render0 : Html ()
render0 =
    internalRenderer { x = -5, y = -5 } walkCyclePlaceholder pokemonPlaceholder Nothing defaultOptions


{-| `1`.
-}
render1 : Coordinates -> Html ()
render1 a =
    internalRenderer a walkCyclePlaceholder pokemonPlaceholder Nothing defaultOptions


{-| `2`.
-}
render2 : Coordinates -> WalkCycle -> Html ()
render2 a b =
    internalRenderer a b pokemonPlaceholder Nothing defaultOptions


{-| `3`.
-}
render3 : Coordinates -> WalkCycle -> Maybe Pokemon -> Html ()
render3 a b c =
    internalRenderer a b c Nothing defaultOptions


{-| `4`.
-}
render4 : Coordinates -> WalkCycle -> Maybe Pokemon -> msg -> Html msg
render4 a b c d =
    internalRenderer a b c (Just d) defaultOptions


{-| `5`.

Render the game.

Important notes:

  - The `msg` is sent each time you click on "Use Pokéball".
  - If you want to use `render5`, make sure to read the docs on the `Options` type alias above.

-}
render5 : Coordinates -> WalkCycle -> Maybe Pokemon -> msg -> Options -> Html msg
render5 a b c d e =
    internalRenderer a b c (Just d) e



-- Options


{-| The last parameter of the last `render` (nr. 5) function.
Allows you to show a Pokéball on the screen.

The `cacheBuster` is necessary to reset the gif animation.
Ideally this value increases each time you show a Pokémon.
This could, for example, be the length of the list of Pokémon you caught.
Assuming you catch every Pokémon you encounter that is.

-}
type alias Options =
    { cacheBuster : Int
    , showPokeball : Bool
    }


{-| The default `Options`.
-}
defaultOptions : Options
defaultOptions =
    { cacheBuster = 0
    , showPokeball = False
    }



------------------------------------------------------------------------
-- Private
------------------------------------------------------------------------
-- 🏞


internalRenderer : Coordinates -> WalkCycle -> Maybe Pokemon -> Maybe msg -> Options -> Html msg
internalRenderer characterPosition characterWalkCycle maybePokemon maybePokemonMsg options =
    div
        [ style "align-items" "center"
        , style "background-color" "#21614A"
        , style "display" "flex"
        , style "height" "100vh"
        , style "left" "0"
        , style "justify-content" "center"
        , style "position" "absolute"
        , style "top" "0"
        , style "width" "100vw"
        ]
        [ node
            "style"
            []
            [ text """
                @font-face {
                  font-family: "pokemon-font";
                  src: url("/assets/pokemon-font.ttf") format("truetype");
                }
              """
            ]

        -- World.
        --
        , div
            [ style "height" (Geometry.coordinateToPixels Geometry.worldSize.y)
            , style "width" (Geometry.coordinateToPixels Geometry.worldSize.x)

            --
            , style "border-radius" "6px"
            , style "overflow" "hidden"
            , style "position" "relative"
            ]
            [ div
                []
                [ World.renderLayer World.current.layer_1
                , World.renderLayer World.current.layer_2
                , Character.render characterPosition characterWalkCycle
                , World.renderLayer (World.current.layer_3 characterPosition)
                , World.renderLayer World.current.layer_4
                ]
            ]

        -- Pokémon overlay.
        --
        , case maybePokemon of
            Just pokemon ->
                div
                    [ style "background" "url(/assets/background.png)"
                    , style "background-position" "center"
                    , style "background-size" "cover"
                    , style "height" "100%"
                    , style "left" "0"
                    , style "position" "fixed"
                    , style "top" "0"
                    , style "width" "100%"
                    ]
                    [ -- Pokémon
                      --
                      div
                        [ attribute "style" imageRenderingStyle ]
                        [ div
                            [ style "background-image" (pokeUrl <| Pokemon.fileName pokemon)
                            , style "background-position" "center"
                            , style "background-repeat" "no-repeat"
                            , style "background-size" "contain"
                            , style "height" "158px"
                            , style "width" "158px"

                            --
                            , style "left" "50%"
                            , style "position" "absolute"
                            , style "top" "38.2%"
                            , style "transform" "translate(-50%, -50%)"

                            --
                            , style "transition" "opacity 150ms linear 0.75s"

                            --
                            , style "opacity"
                                (if options.showPokeball then
                                    "0"

                                 else
                                    "1"
                                )
                            ]
                            []
                        ]

                    -- Pokéball
                    --
                    , if options.showPokeball then
                        let
                            v =
                                String.fromInt options.cacheBuster
                        in
                        div
                            [ style "background-image" ("url(/assets/pokeball-a.gif?v=" ++ v ++ ")")
                            , style "background-position" "center"
                            , style "background-repeat" "no-repeat"
                            , style "background-size" "contain"
                            , style "height" "45px"
                            , style "width" "36px"

                            --
                            , style "left" "calc(50% - 48px)"
                            , style "position" "absolute"
                            , style "top" "calc(38.2% + 62px)"
                            , style "transform" "translate(-50%, -50%)"
                            ]
                            []

                      else
                        text ""

                    -- Text
                    --
                    , div
                        [ style "color" "white"
                        , style "font-size" "22px"
                        , style "font-family" "pokemon-font"
                        , style "line-height" "1.75"

                        --
                        , style "left" "50%"
                        , style "max-width" "490px"
                        , style "position" "absolute"
                        , style "top" "61.8%"
                        , style "transform" "translate(-50%, -12.5%)"
                        , style "width" "65%"

                        --
                        , style "-webkit-font-smoothing" "none"
                        , style "font-smooth" "never"
                        ]
                        [ div
                            [ style "text-align" "center" ]
                            [ text ("A wild " ++ Pokemon.name pokemon ++ " appeared!") ]
                        , br
                            []
                            []
                        , a
                            (case maybePokemonMsg of
                                Just msg ->
                                    [ style "cursor" "pointer"
                                    , onClick msg
                                    ]

                                Nothing ->
                                    [ style "cursor" "not-allowed" ]
                            )
                            [ text "• use POKE BALL" ]
                        ]
                    ]

            Nothing ->
                text ""

        -- Color overlay.
        --
        , div
            [ style "background" "rgb(251, 148, 83)"
            , style "height" "100%"
            , style "left" "0"
            , style "mix-blend-mode" "darken"
            , style "opacity" "0.35"
            , style "pointer-events" "none"
            , style "position" "fixed"
            , style "top" "0"
            , style "width" "100%"
            ]
            []
        ]


imageRenderingStyle : String
imageRenderingStyle =
    String.concat
        [ "image-rendering: pixelated;"
        , "image-rendering: -moz-crisp-edges;"
        , "image-rendering: crisp-edges;"
        ]


pokeUrl : String -> String
pokeUrl fileName =
    "url(/assets/pokemon/" ++ fileName ++ ")"



-- Placeholders


pokemonPlaceholder : Maybe Pokemon
pokemonPlaceholder =
    Nothing


walkCyclePlaceholder : WalkCycle
walkCyclePlaceholder =
    { direction = Down
    , duration = 0
    , index = 0
    }
