module Character exposing (Direction(..), WalkCycle, initialWalkCycle, move, render, walk)

{-| Everything related to the character in the game.

@docs Direction, WalkCycle, initialWalkCycle, move, render, walk

-}

import Asset
import Geometry exposing (..)
import Html exposing (Html, div)
import Html.Attributes exposing (style)
import Keyboard exposing (..)
import World



-- 🌳


{-| 4 directional.
-}
type Direction
    = Up
    | Down
    | Left
    | Right


{-| The walk-cycle animation.
-}
type alias WalkCycle =
    { direction : Direction
    , duration : Int
    , index : Int
    }



-- Movement


{-| Move the character in one direction.
-}
move : Direction -> Coordinates -> Coordinates
move direction { x, y } =
    let
        destination =
            case direction of
                Up ->
                    { x = x, y = max (y - 1) 0 }

                Down ->
                    { x = x, y = min (y + 1) worldSize.y }

                Left ->
                    { x = max (x - 1) 0, y = y }

                Right ->
                    { x = min (x + 1) worldSize.x, y = y }
    in
    if World.runningIntoObstacle World.current destination then
        -- If we try to move onto an obstacle, stay put.
        { x = x, y = y }

    else
        -- If not, move.
        destination


{-| Generate an initial walkcycle based on a given direction.
-}
initialWalkCycle : Direction -> WalkCycle
initialWalkCycle direction =
    { direction = Down, duration = 2, index = 0 }


{-| Update the character's walkcycle based on a given walking direction.
-}
walk : Direction -> WalkCycle -> WalkCycle
walk direction cycle =
    { direction = direction
    , duration = cycle.duration
    , index =
        if (cycle.index + 1) <= cycle.duration then
            cycle.index + 1

        else
            0
    }



-- 🏞


{-| Render the character.
-}
render : Coordinates -> WalkCycle -> Html msg
render characterPosition walkCycle =
    let
        spriteCoordinates =
            { x =
                walkCycle.index
            , y =
                case walkCycle.direction of
                    Up ->
                        0

                    Down ->
                        1

                    Left ->
                        2

                    Right ->
                        3
            }
    in
    div
        (List.concat
            [ sprite (Asset.path ++ "/walk-cycle.png") spriteCoordinates

            -- Styles
            , [ style "height" (Geometry.intToPixels <| Geometry.blockSize * 2)
              , style "width" (Geometry.intToPixels <| Geometry.blockSize * 2)

              --
              , style "left" (Geometry.coordinateToPixels characterPosition.x)
              , style "top" (Geometry.coordinateToPixels characterPosition.y)

              --
              , style "margin-left" (Geometry.intToPixels <| Geometry.blockSize // -2)
              , style "margin-top" (Geometry.intToPixels <| Geometry.blockSize * -1)

              --
              , style "background-size" "300%"
              , style "position" "absolute"
              ]
            ]
        )
        []



-----------------------------------------
-- Private
-----------------------------------------


sprite : String -> Coordinates -> List (Html.Attribute msg)
sprite url { x, y } =
    let
        ctp n =
            Geometry.intToPixels (n * (Geometry.blockSize * 2))
    in
    [ style "background-image" ("url(" ++ url ++ ")")
    , style "background-position" (ctp -x ++ " " ++ ctp -y)
    ]
