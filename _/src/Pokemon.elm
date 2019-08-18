module Pokemon exposing (Pokemon(..), ballAnimationDuration, basedOnTime, fileName, name)

{-| Pokémon!

@docs Pokemon, ballAnimationDuration, basedOnTime, fileName, name

-}

import Time



-- 🌳


{-| The Pokémon.
-}
type Pokemon
    = Charmander
    | Dragonair
    | Mew
    | Pikachu
    | Snorlax



-- 🦊


{-| Maybe present a Pokémon, based on time.
-}
basedOnTime : Time.Posix -> Maybe Pokemon
basedOnTime time =
    let
        minute =
            Time.toMinute Time.utc time

        second =
            Time.toSecond Time.utc time
    in
    if second == 7 || second == 21 then
        if modBy 2 minute == 0 then
            Just Charmander

        else
            Just Dragonair

    else if second == 42 || second == 56 then
        if modBy 2 minute == 0 then
            Just Pikachu

        else
            Just Snorlax

    else if second == 0 && minute == 0 then
        Just Mew

    else
        Nothing



-- 🏞


{-| Find the .gif filename for a given Pokémon.
-}
fileName : Pokemon -> String
fileName pokemon =
    case pokemon of
        Charmander ->
            "004.gif"

        Dragonair ->
            "148.gif"

        Mew ->
            "151.gif"

        Pikachu ->
            "025f.gif"

        Snorlax ->
            "143.gif"


{-| Find the name of a given Pokémon.
-}
name : Pokemon -> String
name pokemon =
    case pokemon of
        Charmander ->
            "Charmander"

        Dragonair ->
            "Dragonair"

        Mew ->
            "Mew"

        Pikachu ->
            "Pikachu"

        Snorlax ->
            "Snorlax"



-- Animations
--


{-| The duration of the Pokéball gif in milliseconds.
-}
ballAnimationDuration : Float
ballAnimationDuration =
    4750 + 1000
