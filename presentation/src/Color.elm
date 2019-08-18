module Color exposing (Color, background, chardonnay, darkCerulean, grandis, oceanGreen, onyx, pictonBlue, red, rgb, sienna, sunglow, tanHide, text, toString, valencia)

-- Types


type alias Color =
    { alpha : Int, red : Int, green : Int, blue : Int }



-- The Colors


chardonnay =
    rgb 253 195 113


darkCerulean =
    rgb 17 63 136


grandis =
    rgb 253 211 135


oceanGreen =
    rgb 74 162 125


onyx =
    rgb 16 16 16


pictonBlue =
    rgb 65 175 233


red =
    rgb 225 61 38


sienna =
    rgb 136 43 20


sunglow =
    rgb 253 211 69


tanHide =
    rgb 251 148 83


valencia =
    rgb 218 84 68



-- Derivatives


background =
    rgb 247 239 234


text =
    rgb 62 48 39



-- Tools


toString : Color -> String
toString color =
    String.concat
        [ "rgb("
        , String.fromInt color.red
        , ", "
        , String.fromInt color.green
        , ", "
        , String.fromInt color.blue
        , ")"
        ]


rgb : Int -> Int -> Int -> Color
rgb r g b =
    { alpha = 1
    , red = r
    , green = g
    , blue = b
    }
