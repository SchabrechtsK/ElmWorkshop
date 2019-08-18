module Keyboard exposing (ArrowKey(..), keyDecoder, onArrowKeyDown, onArrowKeyUp)

{-| Keyboard stuff.

@docs ArrowKey, keyDecoder, onArrowKeyDown, onArrowKeyUp

-}

import Browser.Events
import Json.Decode as Json exposing (fail, succeed)



-- 🌳


{-| A set of arrow keys from your keyboard.
-}
type ArrowKey
    = ArrowUp
    | ArrowDown
    | ArrowLeft
    | ArrowRight



-- Json


{-| Decode the `key` of a keyboard event into a `ArrowKey`.
-}
keyDecoder : Json.Decoder ArrowKey
keyDecoder =
    Json.andThen
        (\key ->
            case key of
                "ArrowUp" ->
                    succeed ArrowUp

                "ArrowDown" ->
                    succeed ArrowDown

                "ArrowLeft" ->
                    succeed ArrowLeft

                "ArrowRight" ->
                    succeed ArrowRight

                _ ->
                    fail "Not an arrow key"
        )
        (Json.field "key" Json.string)



-- Subscriptions


{-| Subscribe to "downs" of arrow keys.
-}
onArrowKeyDown : (ArrowKey -> msg) -> Sub msg
onArrowKeyDown msg =
    Browser.Events.onKeyDown (Json.map msg keyDecoder)


{-| Subscribe to "ups" of arrow keys.
-}
onArrowKeyUp : (ArrowKey -> msg) -> Sub msg
onArrowKeyUp msg =
    Browser.Events.onKeyUp (Json.map msg keyDecoder)
