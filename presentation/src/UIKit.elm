module UIKit exposing (boldText, code, colored, h1, h1_end, h2, inline, inlineCode, inlineCodeBlock, inlineCodeBlockHtml, link, list, listItem, orderedList, orderedListItem, paragraph, pixelatedImage, prelude, small, smallText, spacer, subtleText)

import Chunky exposing (..)
import Color exposing (Color)
import Font
import Html exposing (Html)
import Html.Attributes exposing (class, href, rel, style, target)
import Regex
import String.Extra as String
import Tachyons.Classes as T



-- Basics


boldText : String -> Html msg
boldText string =
    Html.strong
        []
        [ Html.text string ]


colored : Color -> List (Html msg) -> Html msg
colored color =
    Html.span
        [ style "color" (Color.toString color) ]


inline : List (Html msg) -> Html msg
inline =
    slab
        Html.span
        []
        [ T.dib, T.v_top ]


link : { label : String, url : String } -> Html msg
link { label, url } =
    Html.a
        [ href url
        , rel "noopener noreferrer"
        , target "_blank"

        -- Styles
        , style "color" (Color.toString Color.valencia)
        ]
        [ Html.text label ]


paragraph : List (Html msg) -> Html msg
paragraph =
    slab
        Html.p
        []
        [ T.f4, T.lh_copy ]


prelude : List (Html msg) -> Html msg
prelude =
    chunk
        [ T.f4, T.i, T.lh_copy, T.mb4 ]


smallText : String -> Html msg
smallText string =
    small
        [ Html.text string ]


small : List (Html msg) -> Html msg
small =
    slab
        Html.small
        []
        [ T.o_70 ]


spacer : Html msg
spacer =
    chunk
        [ T.mb2 ]
        []


subtleText : String -> Html msg
subtleText string =
    slab
        Html.span
        []
        [ T.o_70 ]
        [ Html.text string ]



-- Headings


h1 : String -> Html msg
h1 =
    h1_priv Color.tanHide


h1_end : String -> Html msg
h1_end =
    h1_priv (Color.rgb 235 136 181)


h1_priv : Color -> String -> Html msg
h1_priv color str =
    slab
        Html.h1
        [ style "color" (Color.toString color)
        , style "font-family" Font.title
        ]
        [ T.f_headline, T.fw4, T.lh_title, T.ma0, T.mb5 ]
        [ Html.text str ]


h2 : String -> Html msg
h2 str =
    slab
        Html.h2
        [ style "font-family" Font.title
        , style "opacity" "0.95"
        , style "transform" "translate3d(0, 0, 0)"
        ]
        [ T.f_subheadline, T.fw4, T.lh_title, T.ma0, T.mb5 ]
        [ Html.text str ]



-- Lists


list : List (Html msg) -> Html msg
list items =
    slab
        Html.ul
        []
        [ T.f3, T.lh_copy, T.list, T.mb4, T.mt0, T.pa0 ]
        (List.map listItem items)


listItem : Html msg -> Html msg
listItem item =
    slab
        Html.li
        []
        [ T.mb3 ]
        [ item ]


orderedList : List (Html msg) -> Html msg
orderedList items =
    slab
        Html.ol
        []
        [ T.f3, T.lh_copy, T.list, T.mb4, T.mt0, T.pa0, T.tl ]
        (List.map orderedListItem items)


orderedListItem : Html msg -> Html msg
orderedListItem item =
    slab
        Html.li
        []
        [ T.mb3 ]
        [ item ]



-- Code


code : String -> Html msg
code str =
    slab
        Html.pre
        []
        [ T.b__black_10
        , T.b__dashed
        , T.br2
        , T.bw1
        , T.f5
        , T.lh_copy
        , T.ma0
        , T.overflow_scroll
        , T.pa4
        , T.tl
        ]
        [ Html.code
            [ style "font-family" Font.mono
            , style "font-size" "1em"
            ]
            [ str
                |> String.unindent
                |> String.unsurround "\n"
                |> Html.text
            ]
        ]


inlineCode : String -> Html msg
inlineCode str =
    slab
        Html.pre
        []
        [ T.b__black_10
        , T.b__dashed
        , T.br2
        , T.bw1
        , T.dib
        , T.f5
        , T.lh_copy
        , T.ma0
        , T.pa1
        ]
        [ Html.code
            [ style "font-family" Font.mono
            , style "font-size" "1em"
            ]
            [ Html.text str ]
        ]


inlineCodeBlock : String -> Html msg
inlineCodeBlock str =
    inlineCodeBlockHtml
        [ Html.text str ]


inlineCodeBlockHtml : List (Html msg) -> Html msg
inlineCodeBlockHtml html =
    slab
        Html.pre
        []
        [ T.b__black_10
        , T.b__dashed
        , T.br2
        , T.bw1
        , T.dib
        , T.f5
        , T.lh_copy
        , T.ma0
        , T.pa4
        ]
        [ Html.code
            [ style "font-family" Font.mono
            , style "font-size" "1em"
            ]
            html
        ]



-- Images


pixelatedImage : List (Html.Attribute msg) -> Html msg
pixelatedImage attributes =
    Html.img
        (List.append
            attributes
            [ style "transform" "translate3d(0, 0, 0)"

            --
            , [ "pixelated", "-moz-crisp-edges", "crisp-edges" ]
                |> List.map (\val -> "image-rendering: " ++ val)
                |> String.join "; "
                |> Html.Attributes.attribute "style"
            ]
        )
        []
