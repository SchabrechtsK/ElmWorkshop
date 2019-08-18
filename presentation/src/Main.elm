module Main exposing (main)

import Browser
import Browser.Events
import Browser.Navigation as Nav
import Chunky exposing (..)
import Color
import Font
import Html exposing (Html)
import Html.Attributes exposing (href, rel, src, style, width)
import Html.Events exposing (onClick)
import Json.Decode as Decode
import Presentation
import Response
import Slide exposing (..)
import String.Interpolate as String
import Tachyons exposing (tachyons)
import Tachyons.Classes as T
import UIKit
import Url exposing (Url)



-- ⛩


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }



-- 🌳


type alias Model =
    { navKey : Nav.Key
    , slideIndex : Int
    , url : Url
    }


init : () -> Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( -----------------------------------------
      -- Initial model
      -----------------------------------------
      { navKey = key
      , slideIndex = Slide.indexFromUrl url
      , url = url
      }
      -----------------------------------------
      -- Initial command
      -----------------------------------------
    , Cmd.none
    )



-- 📣


type Msg
    = -----------------------------------------
      -- Slides
      -----------------------------------------
      GoToNextSlide
    | GoToPreviousSlide
      -----------------------------------------
      -- URL
      -----------------------------------------
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        chill =
            ( model, Cmd.none )
    in
    case msg of
        -----------------------------------------
        -- Slides
        -----------------------------------------
        GoToNextSlide ->
            (model.slideIndex + 1)
                |> Slide.validateIndex
                |> Maybe.map (changeLocation model >> Response.res model)
                |> Maybe.withDefault chill

        GoToPreviousSlide ->
            (model.slideIndex - 1)
                |> Slide.validateIndex
                |> Maybe.map (changeLocation model >> Response.res model)
                |> Maybe.withDefault chill

        -----------------------------------------
        -- URL
        -----------------------------------------
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.navKey <| Url.toString url )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            { model | slideIndex = Slide.indexFromUrl url, url = url }
                |> Response.withNone


changeLocation : Model -> Int -> Cmd Msg
changeLocation model idx =
    let
        url =
            model.url
    in
    (idx + 1)
        |> String.fromInt
        |> (\frag -> { url | fragment = Just frag })
        |> Url.toString
        |> Nav.pushUrl model.navKey



-- 📰


subscriptions : Model -> Sub Msg
subscriptions _ =
    Decode.string
        |> Decode.field "key"
        |> Decode.andThen
            (\key ->
                case Slide.directionFromKey key of
                    Just Backwards ->
                        Decode.succeed GoToPreviousSlide

                    Just Forwards ->
                        Decode.succeed GoToNextSlide

                    Nothing ->
                        Decode.fail "No key of importance was pressed, carry on."
            )
        |> Browser.Events.onKeyDown



-- 🗺


view : Model -> Browser.Document Msg
view model =
    { title = "Elm Workshop"
    , body =
        [ brick
            (rootAttributes model)
            [ T.overflow_scroll, T.vh_100 ]
            (rootNodes model)
        ]
    }



-- 🗺  ~  Root


rootAttributes : Model -> List (Html.Attribute Msg)
rootAttributes _ =
    [ style "background-color" (Color.toString Color.background)
    , style "color" (Color.toString Color.text)
    , style "font-family" Font.default
    , style "text-rendering" "optimizeLegibility"
    ]


rootNodes : Model -> List (Html Msg)
rootNodes model =
    [ -----------------------------------------
      -- Tachyons
      -----------------------------------------
      tachyons.css

    -----------------------------------------
    -- Google Fonts
    -----------------------------------------
    , Html.node
        "link"
        [ rel "stylesheet"

        --
        , [ "https://fonts.googleapis.com/css?family=Permanent+Marker"
          , "Roboto:300,400,400i,500,700"
          , "Fira+Mono:400,700"
          ]
            |> String.join "|"
            |> Html.Attributes.href
        ]
        []

    -----------------------------------------
    -- CSS Counters
    -----------------------------------------
    , Html.node
        "style"
        []
        [ Html.text """
            ol {
                counter-reset: orderedList;
            }

            ol li:before {
                content: counters(orderedList, '.') '.\u{2002}';
                counter-increment: orderedList;
                opacity: 0.525;
            }
          """
        ]

    -----------------------------------------
    -- Slide
    -----------------------------------------
    , Presentation.slides
        |> List.drop model.slideIndex
        |> List.head
        |> Maybe.map Slide.render
        |> Maybe.withDefault
            (chunk
                [ T.absolute
                , T.absolute__fill
                , T.f4
                , T.flex
                , T.flex_column
                , T.i
                , T.items_center
                , T.justify_center
                ]
                [ chunk
                    [ T.mb5 ]
                    [ UIKit.pixelatedImage
                        [ src "/assets/pokemon/054.gif"
                        , width 275
                        ]
                    ]
                , UIKit.subtleText "Uh-oh, I couldn't find this slide."
                ]
            )

    -----------------------------------------
    -- Slide navigation
    -----------------------------------------
    , brick
        [ style "background-color" (Color.toString Color.background)

        -- No selection
        ---------------
        , style "-webkit-user-select" "none"
        , style "-moz-user-select" "none"
        , style "-ms-user-select" "none"
        , style "user-select" "none"

        -- Events
        ---------
        , onClick GoToNextSlide
        ]
        [ T.bottom_0
        , T.fixed
        , T.f5
        , T.fw5
        , T.left_0
        , T.pa4
        , T.pointer
        , T.right_0
        , T.tc
        ]
        [ [ String.fromInt (model.slideIndex + 1)
          , String.fromInt Presentation.length
          ]
            |> String.interpolate "{0} / {1}"
            |> Html.text
            |> List.singleton
            |> chunk [ T.o_20 ]
        ]
    ]
