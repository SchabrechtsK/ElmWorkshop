module Slide exposing (Direction(..), directionFromKey, indexFromUrl, render, validateIndex)

import Chunky exposing (..)
import Color
import Html exposing (Html)
import Html.Attributes exposing (class, style)
import Presentation
import Tachyons.Classes as T
import Url exposing (Url)



-- {public} Direction


type Direction
    = Backwards
    | Forwards


directionFromKey : String -> Maybe Direction
directionFromKey string =
    case string of
        "ArrowLeft" ->
            Just Backwards

        "ArrowRight" ->
            Just Forwards

        _ ->
            Nothing



-- {public} Index functions


indexFromUrl : Url -> Int
indexFromUrl url =
    case url.fragment of
        Just frag ->
            frag
                |> String.toInt
                |> Maybe.map (\x -> x - 1)
                |> Maybe.withDefault defaultSlideIndex

        Nothing ->
            defaultSlideIndex


validateIndex : Int -> Maybe Int
validateIndex idx =
    if idx >= 0 && idx < Presentation.length then
        Just idx

    else
        Nothing



-- {public} Render


render : List (Html msg) -> Html msg
render slide =
    chunk
        [ T.flex
        , T.flex_column
        , T.items_center
        , T.justify_center
        , T.min_vh_100
        , T.overflow_auto
        , T.pb5
        , T.pt3
        , T.tc
        ]
        slide



-- Constants


defaultSlideIndex : Int
defaultSlideIndex =
    0
