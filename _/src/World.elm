module World exposing (World, anyHighGrassAt, current, renderLayer, runningIntoObstacle)

{-| All the worldly things.

@docs World, anyHighGrassAt, current, renderLayer, runningIntoObstacle

-}

import Asset
import Geometry exposing (..)
import Html exposing (Html, div)
import Html.Attributes exposing (style)
import Random
import Time



-- 🌳


{-| The layers of the world.
-}
type alias World =
    { layer_1 : List PlacedTile
    , layer_2 : List PlacedTile
    , layer_3 : Coordinates -> List PlacedTile
    , layer_4 : List PlacedTile
    }



-- 🗺


{-| The current world.
-}
current : World
current =
    v1



-- 🏞


{-| Render a single layer of a world.
-}
renderLayer : List PlacedTile -> Html msg
renderLayer layer =
    div [] (List.map renderTile layer)



-- 🧝‍ vs 🗺


{-| High-grass detection.
-}
anyHighGrassAt : Coordinates -> Bool
anyHighGrassAt coordinates =
    List.any
        (\{ position, tile } ->
            tile == HighGrass && position == coordinates
        )
        current.layer_2


{-| Obstacle detection.
-}
runningIntoObstacle : World -> Coordinates -> Bool
runningIntoObstacle world target =
    List.foldl
        (\placedTile bool ->
            if bool == False then
                isObstacle placedTile.tile && tileCollision target placedTile

            else
                bool
        )
        False
        world.layer_2



------------------------------------------------------------------------
-- Private
------------------------------------------------------------------------
-- 🌳


type Tile
    = LowGrass
    | MediumGrass
    | HighGrass
      -- Flowers
    | FlowerA
    | FlowerB
    | FlowerC
      -- Obstacles
    | BigTree
    | Bush
    | Lake
    | SmallTree


type alias PlacedTile =
    { position : Coordinates
    , tile : Tile
    }



-- 🗺
--
-- First world.


v1 : World
v1 =
    { ------------------------------------
      --- Layer 1
      ------------------------------------
      -- Generate enough `LowGrass` tiles
      -- to cover the entire area/world.
      layer_1 =
        let
            sizeOfTile =
                .x (tileSize LowGrass)

            area =
                { x = (worldSize.x // sizeOfTile) + 1
                , y = (worldSize.y // sizeOfTile) + 1
                }
        in
        coverArea area { x = 0, y = 0 } LowGrass

    ------------------------------------
    --- Layer 2
    ------------------------------------
    -- Generate enough `HighGrass` tiles
    -- to cover the entire area/world except the border.
    , layer_2 =
        let
            sizeOfTile =
                .x (tileSize HighGrass)

            offset =
                { x = 1, y = 1 }

            area =
                { x = (worldSize.x - (2 * offset.x)) // sizeOfTile
                , y = (worldSize.y - (2 * offset.y)) // sizeOfTile
                }

            center =
                { x = offset.x + area.x // 2 - 2
                , y = offset.y + area.y // 2 - 2
                }

            grassWithFlowers =
                List.foldl
                    (\coordinates ->
                        coordinates.x
                            + coordinates.y
                            + 1
                            |> flowerTile
                            |> replaceTileAtCoordinates coordinates
                    )
                    (coverArea area offset HighGrass)
                    flowers
        in
        grassWithFlowers
            |> replaceTileAtCoordinates center Lake
            |> removeTileAtCoordinates { x = center.x + 1, y = center.y }
            |> removeTileAtCoordinates { x = center.x + 2, y = center.y }
            |> removeTileAtCoordinates { x = center.x + 0, y = center.y + 1 }
            |> removeTileAtCoordinates { x = center.x + 1, y = center.y + 1 }
            |> removeTileAtCoordinates { x = center.x + 2, y = center.y + 1 }
            |> removeTileAtCoordinates { x = center.x + 0, y = center.y + 2 }
            |> removeTileAtCoordinates { x = center.x + 1, y = center.y + 2 }
            |> removeTileAtCoordinates { x = center.x + 2, y = center.y + 2 }
            |> replaceTileAtCoordinates { x = center.x + 3, y = center.y } BigTree
            |> removeTileAtCoordinates { x = center.x + 4, y = center.y }
            |> removeTileAtCoordinates { x = center.x + 3, y = center.y + 1 }
            |> removeTileAtCoordinates { x = center.x + 4, y = center.y + 1 }
            |> removeTileAtCoordinates { x = center.x + 3, y = center.y + 2 }
            |> removeTileAtCoordinates { x = center.x + 4, y = center.y + 2 }

    ------------------------------------
    --- Layer 3
    ------------------------------------
    -- Based on where the character is, place some `HighGrass` tiles.
    -- This is to make the character partially hidden when he/she is
    -- walking through high grass.
    , layer_3 =
        \characterPosition ->
            List.filter
                (\placedTile ->
                    List.any
                        (\{ position, tile } ->
                            tile == HighGrass && position == placedTile.position
                        )
                        v1.layer_2
                )
                [ placeTile HighGrass { x = characterPosition.x, y = characterPosition.y }
                , placeTile HighGrass { x = characterPosition.x - 1, y = characterPosition.y }
                , placeTile HighGrass { x = characterPosition.x + 1, y = characterPosition.y }
                ]

    ------------------------------------
    -- Layer 4
    ------------------------------------
    , layer_4 =
        [ placeTile BigTree { x = worldSize.x // 2 + 1, y = worldSize.y // 2 - 2 }
        ]
    }



-- 🏞
--
-- Rendering.


renderTile : PlacedTile -> Html msg
renderTile { position, tile } =
    div
        [ style "left" (coordinateToPixels position.x)
        , style "top" (coordinateToPixels position.y)

        --
        , style "height" (coordinateToPixels (tileSize tile).y)
        , style "width" (coordinateToPixels (tileSize tile).x)

        --
        , style "background-image" (tileAsset tile)
        , style "margin-top" (coordinateToPixels (tileOffset tile).y)
        , style "position" "absolute"
        ]
        []



-- 🌻
--
-- Flowers.


flowers : List Coordinates
flowers =
    let
        offset =
            { x = 2, y = 2 }

        numberGenerator =
            Random.int 0 (worldSize.x - (2 * offset.x) - 1)

        amountOfFlowers =
            10

        foldingFunction _ ( acc, seed ) =
            let
                ( x, newSeed ) =
                    Random.step numberGenerator seed

                ( y, newSeed2 ) =
                    Random.step numberGenerator newSeed
            in
            ( { x = offset.x + x, y = offset.y + y } :: acc
            , newSeed2
            )
    in
    amountOfFlowers
        |> List.range 1
        |> List.foldl foldingFunction ( [], Random.initialSeed 20 )
        |> Tuple.first


flowerTile : Int -> Tile
flowerTile n =
    case modBy 3 n of
        0 ->
            FlowerA

        1 ->
            FlowerB

        _ ->
            FlowerC



-- 🀰
--
-- Tiles.


isObstacle : Tile -> Bool
isObstacle tile =
    case tile of
        LowGrass ->
            False

        MediumGrass ->
            False

        HighGrass ->
            False

        ------------------------------------
        -- Flowers
        ------------------------------------
        FlowerA ->
            False

        FlowerB ->
            False

        FlowerC ->
            False

        ------------------------------------
        -- Other
        ------------------------------------
        _ ->
            True


placeTile : Tile -> Coordinates -> PlacedTile
placeTile tile coordinates =
    { position = coordinates
    , tile = tile
    }


replaceTileAtCoordinates : Coordinates -> Tile -> List PlacedTile -> List PlacedTile
replaceTileAtCoordinates coordinates tile =
    List.map
        (\placedTile ->
            if placedTile.position == coordinates then
                { placedTile | tile = tile }

            else
                placedTile
        )


removeTileAtCoordinates : Coordinates -> List PlacedTile -> List PlacedTile
removeTileAtCoordinates coordinates =
    List.filter (.position >> (/=) coordinates)


tileAsset : Tile -> String
tileAsset tile =
    (\fileName ->
        String.concat
            [ "url(", Asset.path, "/tiles/", fileName, ".png)" ]
    )
        (case tile of
            LowGrass ->
                "low-grass"

            MediumGrass ->
                "medium-grass"

            HighGrass ->
                "high-grass-3"

            ------------------------------------
            -- Flowers
            ------------------------------------
            FlowerA ->
                "flower-1"

            FlowerB ->
                "flower-2"

            FlowerC ->
                "flower-3"

            ------------------------------------
            -- Obstacles
            ------------------------------------
            BigTree ->
                "tree-1"

            Lake ->
                "lake"

            _ ->
                "TODO"
        )


tileCollision : Coordinates -> PlacedTile -> Bool
tileCollision target placedTile =
    let
        start =
            placedTile.position

        offset =
            tileOffset placedTile.tile

        size =
            tileSize placedTile.tile

        end =
            { x = start.x + size.x - 1 + offset.x
            , y = start.y + size.y - 1 + offset.y
            }
    in
    (target.x >= start.x)
        && (target.x <= end.x)
        && (target.y >= start.y)
        && (target.y <= end.y)


tileOffset : Tile -> Coordinates
tileOffset tile =
    case tile of
        BigTree ->
            { x = 0, y = -1 }

        _ ->
            { x = 0, y = 0 }


tileSize : Tile -> Coordinates
tileSize tile =
    case tile of
        LowGrass ->
            { x = 3, y = 3 }

        ------------------------------------
        -- Obstacles
        ------------------------------------
        BigTree ->
            { x = 2, y = 4 }

        Lake ->
            { x = 3, y = 3 }

        ------------------------------------
        -- Other
        ------------------------------------
        _ ->
            { x = 1, y = 1 }



-- 🔩
--
-- Utilities.


coverArea : Coordinates -> Coordinates -> Tile -> List PlacedTile
coverArea area offset tile =
    let
        sizeOfTile =
            tileSize tile
    in
    0
        |> List.repeat area.x
        |> List.repeat area.y
        |> List.indexedMap
            (\rowIndex rowColumns ->
                List.indexedMap
                    (\columnIndex _ ->
                        { position =
                            { x = offset.x + columnIndex * sizeOfTile.x
                            , y = offset.y + rowIndex * sizeOfTile.y
                            }
                        , tile = tile
                        }
                    )
                    rowColumns
            )
        |> List.concat
