module Geometry exposing (Coordinates, blockSize, coordinateToPixels, intToPixels, worldSize)

{-| Everything related to geometry.

@docs Coordinates, blockSize, coordinateToPixels, intToPixels, worldSize

-}

-- 🌳


{-| 2D coordinates. For example, `characterPosition = { x = 8, y = 7 }`.
-}
type alias Coordinates =
    { x : Int, y : Int }



-- 🌏  ~  Constants


{-| The size of one "block" (or square).
Tiles are made up from multiple blocks.
-}
blockSize : Int
blockSize =
    32


{-| The size of the area we can walk around in.
-}
worldSize : Coordinates
worldSize =
    { x = 20, y = 20 }



-- 📐


{-| Translate a coordinate into a CSS string using the `px` unit.
-}
coordinateToPixels : Int -> String
coordinateToPixels n =
    intToPixels (n * blockSize)


{-| Translate an integer into a CSS string using the `px` unit.
-}
intToPixels : Int -> String
intToPixels n =
    String.fromInt n ++ "px"
