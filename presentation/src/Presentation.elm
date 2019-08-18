module Presentation exposing (length, slides)

{-| The content of the presentation.
-}

import Chunky exposing (..)
import Color
import Html exposing (Html, em, span, strong, text, u)
import Html.Attributes exposing (src, style, width)
import Tachyons exposing (classes)
import Tachyons.Classes as T
import UIKit



-- {public} Content


length : Int
length =
    List.length slides


slides : List (List (Html msg))
slides =
    [ -----------------------------------------
      -----------------------------------------
      -----------------------------------------
      [ UIKit.h1 "Elm workshop"

      -- Charmander!
      , UIKit.pixelatedImage
            [ src "/assets/pokemon/004.gif"
            , width 275
            ]
      ]

    -----------------------------------------
    -----------------------------------------
    -----------------------------------------
    , [ brick
            [ style "background-image" "url(/assets/base-screen.jpg)"
            , style "background-position" "center"
            , style "background-size" "cover"
            , style "filter" "grayscale(100%)"
            ]
            [ T.absolute
            , T.absolute__fill
            , T.z_2
            ]
            []
      , brick
            [ style "color" (Color.toString Color.grandis) ]
            [ T.absolute
            , T.absolute__fill
            , T.flex
            , T.items_center
            , T.justify_center
            , T.z_3
            ]
            [ UIKit.h2 "What we're building"
            ]
      ]

    -----------------------------------------
    -----------------------------------------
    -----------------------------------------
    , [ UIKit.h2 "Follow along"
      , UIKit.list
            [ UIKit.link
                { label = "https://elmworkshop.icidasset.com/"
                , url = "https://elmworkshop.icidasset.com/"
                }
            , UIKit.smallText
                "(this presentation is built with Elm as well)"
            , lineBreak
            , UIKit.prelude
                [ text "Alternatively you can run the presentation yourself,"
                , lineBreak
                , text "it'll be in the zip file we're downloading later."
                ]
            ]
      ]

    -----------------------------------------
    -----------------------------------------
    -----------------------------------------
    , [ UIKit.h2 "What is Elm?"
      , UIKit.list
            [ text "A simple functional language that helps you build web applications."
            , text "Functional? Pretty much everything is a function."
            , text "―"
            , UIKit.smallText "https://guide.elm-lang.org/"
            , UIKit.smallText "https://icidasset.com/writings/building-blocks/"
            ]
      ]

    -----------------------------------------
    -----------------------------------------
    -----------------------------------------
    , [ UIKit.h2 "Why Elm?"
      , UIKit.list
            [ UIKit.inline
                [ UIKit.boldText "It's safer & friendlier than Javascript"
                , lineBreak
                , UIKit.smallText "Friendly error messages, immutability & the Elm architecture."
                ]
            , UIKit.inline
                [ UIKit.boldText "It makes you think more about your code & data"
                , lineBreak
                , UIKit.smallText "Custom types, pure functions & exhaustive case expressions."
                ]
            , UIKit.inline
                [ UIKit.boldText "It's easy to refactor "
                , lineBreak
                , UIKit.smallText "Errors at compile time, ie. no runtime errors."
                ]
            ]
      ]

    -----------------------------------------
    -----------------------------------------
    -----------------------------------------
    , [ UIKit.h2 "How to install"
      , UIKit.orderedList
            [ UIKit.inline
                [ text "Go to "
                , UIKit.link
                    { label = "https://elm-lang.org"
                    , url = "https://elm-lang.org"
                    }
                ]
            , UIKit.inline
                [ text "Click on the "
                , UIKit.boldText "Install"
                , text " button"
                ]
            , UIKit.inline
                [ text "Follow the instructions" ]
            ]
      , UIKit.prelude
            [ UIKit.smallText "OR" ]
      , UIKit.code "brew install elm"
      ]

    -----------------------------------------
    -----------------------------------------
    -----------------------------------------
    , [ UIKit.h2 "Optional tools"
      , UIKit.prelude [ text "These will help you write your code easier and faster." ]
      , UIKit.orderedList
            [ UIKit.inline
                [ UIKit.link
                    { label = "elm-format"
                    , url = "https://github.com/avh4/elm-format#elm-format"
                    }
                , lineBreak
                , text "Automatic code formatting."
                , lineBreak
                , UIKit.smallText "Must have 👍"
                ]
            , UIKit.inline
                [ UIKit.link
                    { label = "elm-jutsu"
                    , url = "https://atom.io/packages/elmjutsu"
                    }
                , lineBreak
                , text "Autocomplete & error highlighting."
                , lineBreak
                , UIKit.smallText "Atom editor only though."
                ]
            ]
      ]

    -----------------------------------------
    -----------------------------------------
    -----------------------------------------
    , [ UIKit.h2 "What does it look like?"
      , UIKit.code """
            {-| What follows is a function. -}
            doSomething : Bool -> Int -> { tag : String, count : Int }
            doSomething a b =
                [ case a of
                    True -> 1
                    False -> 2

                -- a single line comment
                , 3
                , 4
                ]
                    |> someOtherFunction
                    |> andAnotherFunction b
         """
      , UIKit.paragraph
            [ text "All will be explained later, but you can"
            , lineBreak
            , text "check out the "
            , UIKit.link
                { label = "Elm website"
                , url = "https://elm-lang.org/docs/syntax"
                }
            , text " in the meantime."
            ]
      ]

    -----------------------------------------
    -----------------------------------------
    -----------------------------------------
    , [ UIKit.h2 "The Class Is On"
      , UIKit.orderedList
            [ UIKit.inline
                [ text "Download "
                , UIKit.link
                    { label = "https://bit.ly/elm-pokemon"
                    , url = "https://bit.ly/elm-pokemon"
                    }
                , text " and extract it somewhere."
                ]
            , UIKit.inline
                [ text "Open editor & terminal in the "
                , UIKit.boldText "materials"
                , text " directory."
                ]
            , text "Look around a bit."
            , UIKit.inline
                [ text "Open up the "
                , UIKit.link
                    { label = "Elm documentation"
                    , url = "https://package.elm-lang.org/packages/elm/core/latest/"
                    }
                , text "."
                , lineBreak
                , UIKit.smallText "You might need this later on."
                ]
            ]
      ]

    -----------------------------------------
    -----------------------------------------
    -----------------------------------------
    , [ UIKit.h2 "Where do we start?"
      , UIKit.list
            [ UIKit.inline
                [ text "We start with this file called "
                , UIKit.boldText "src/Main.elm"
                ]
            , text "The point where everything comes together"
            , UIKit.inline
                [ text "Elm's name for this entry point is a "
                , UIKit.colored Color.red [ UIKit.boldText "Program" ]
                ]
            ]
      ]

    -----------------------------------------
    -----------------------------------------
    -----------------------------------------
    , [ UIKit.h2 "⛩"
      , UIKit.list
            [ UIKit.inline
                [ text "First lesson, "
                , UIKit.colored Color.red [ UIKit.boldText "Types" ]
                , text "."
                ]
            , UIKit.inline
                [ em [] [ text "A " ]
                , u [] [ text "set" ]
                , em [] [ text " of things having common characteristics." ]
                ]
            , UIKit.inlineCodeBlock "type Pokemon"
            ]
      ]

    -----------------------------------------
    -----------------------------------------
    -----------------------------------------
    , [ UIKit.h2 "⛩"
      , UIKit.code
            """
            type String  = "a" | "b" | "c" | …          (not valid syntax)
            type Int     = 1 | 2 | 3 | …                (not valid syntax)
            type Bool    = True | False
            type Pokemon = Charmander | Pikachu | …
            """
      , UIKit.paragraph
            [ text "The things "
            , UIKit.boldText "after"
            , text " the "
            , UIKit.inlineCode "="
            , text " sign are "
            , UIKit.boldText "values"
            , text ":"
            ]
      , UIKit.code
            """
            catchPokemon Pikachu
            """
      , UIKit.paragraph
            [ UIKit.smallText "(this is a function call)" ]
      ]

    -----------------------------------------
    -----------------------------------------
    -----------------------------------------
    , [ UIKit.h2 "⛩"
      , UIKit.paragraph
            [ text "Types can have "
            , UIKit.boldText "parameters "
            , UIKit.smallText "(or in other words, variables)"
            ]
      , UIKit.code
            """
            type Maybe param = Just param | Nothing
            """
      , UIKit.paragraph
            [ UIKit.inlineCode "Just"
            , text " becomes a function with one parameter."
            , lineBreak
            , text "Which can be of the type you provided."
            , lineBreak
            , UIKit.smallText "Which you would use as follows:"
            ]
      , UIKit.code
            """
            caughtPokemon : Maybe Pokemon
            caughtPokemon = Just Pikachu
            """
      , UIKit.paragraph
            [ UIKit.smallText "(this is a function without parameters, a constant)"
            ]
      ]

    -----------------------------------------
    -----------------------------------------
    -----------------------------------------
    , [ UIKit.h2 "⛩"
      , UIKit.paragraph
            [ text "Besides these kinds of types, you also have some "
            , UIKit.boldText "special ones"
            , text "."
            ]
      , UIKit.code
            """
            person : { name : String, age : Int }
            """
      , (UIKit.paragraph << List.singleton << UIKit.small)
            [ text "The type of "
            , UIKit.inlineCode "person"
            , text " is a record type,"
            , lineBreak
            , text "which consist of a String and an Int."
            ]
      , UIKit.code
            """
            results : (List String, List Error)
            """
      , (UIKit.paragraph << List.singleton << UIKit.small)
            [ text "The type of "
            , UIKit.inlineCode "results"
            , text " is a tuple type,"
            , lineBreak
            , text "of which the first element is a list of strings"
            , lineBreak
            , text " and the second is a list of errors."
            ]
      ]

    -----------------------------------------
    -----------------------------------------
    -----------------------------------------
    , [ UIKit.h2 "⛩"
      , UIKit.paragraph
            [ text "To make our lives a bit easier, we can have "
            , UIKit.boldText "type aliases."
            ]
      , UIKit.code
            """
            person : { name : String, age : Int }
            person = { … }
            """
      , UIKit.paragraph
            [ text "can be written as:"
            ]
      , UIKit.code
            """
            type alias Person = { name : String, age : Int }

            person : Person
            person = { … }

            siblingOfPerson : Person
            siblingOfPerson = { … }
            """
      , UIKit.paragraph
            [ text "So that it becomes easier to reuse."
            , lineBreak
            , UIKit.small
                [ text "(ps, the stuff after the "
                , UIKit.inlineCode ":"
                , text " is called the "
                , UIKit.boldText "type signature"
                , text ")"
                ]
            ]
      ]

    -----------------------------------------
    -----------------------------------------
    -----------------------------------------
    , [ UIKit.h2 "⛩"
      , UIKit.list
            [ UIKit.inline
                [ text "Our "
                , UIKit.colored Color.red [ UIKit.boldText "Program" ]
                , text " is a type."
                ]
            , UIKit.subtleText "Made more specific by these type parameters:"
            , UIKit.inline
                [ UIKit.boldText "Flags"
                , text ", things passing through the program."
                ]
            , UIKit.inline
                [ UIKit.boldText "Model"
                , text ", what does our Elm world/app look like."
                ]
            , UIKit.inline
                [ UIKit.boldText "Msg"
                , text ", what can happen in our Elm world/app."
                ]
            , UIKit.smallText "(these programs come in different shapes)"
            ]
      ]

    -----------------------------------------
    -----------------------------------------
    -----------------------------------------
    , [ UIKit.h2 "Let's get to it"
      , UIKit.list
            [ text "What is the Elm compiler telling us to do?"
            , UIKit.smallText "Try to compile the Elm code:"
            , UIKit.code """
                elm reactor
                open http://localhost:8000/src/Main.elm
              """
            ]
      ]

    -----------------------------------------
    -----------------------------------------
    -----------------------------------------
    , [ brick
            [ style "background-image" "url(/assets/error-screenshot.png)"
            , style "background-position" "center"
            , style "background-size" "cover"
            , style "filter" "grayscale(100%)"
            ]
            [ T.absolute
            , T.absolute__fill
            , T.z_2
            ]
            []
      , brick
            [ style "color" (Color.toString Color.grandis) ]
            [ T.absolute
            , T.absolute__fill
            , T.flex
            , T.items_center
            , T.justify_center
            , T.z_3
            ]
            [ UIKit.h2 "I know, we got this"
            ]
      ]

    -----------------------------------------
    -----------------------------------------
    -----------------------------------------
    , [ UIKit.h2 "🌳"
      , UIKit.paragraph
            [ text "The compiler can't find the "
            , UIKit.boldText "Model"
            , text " type."
            , lineBreak
            , text "So let's create it."
            , lineBreak
            , lineBreak
            ]
      , UIKit.orderedList
            [ UIKit.inline
                [ text "Replace the "
                , UIKit.inlineCode "TODO"
                , text " with a "
                , UIKit.boldText "Model"
                , text " type alias."
                ]
            , text "Hold on, we don't know yet what it's supposed to be?"
            , UIKit.inline
                [ text "Let's use a placeholder for now."
                , UIKit.spacer
                , UIKit.inlineCodeBlock "type alias Model = ()"
                ]
            , text "Refresh the page."
            ]
      ]

    -----------------------------------------
    -----------------------------------------
    -----------------------------------------
    , [ UIKit.h2 "📣"
      , UIKit.paragraph
            [ text "The "
            , UIKit.boldText "Msg"
            , text " type isn't found either."
            , lineBreak
            , text "Let's add that as well."
            , lineBreak
            , lineBreak
            ]
      , UIKit.orderedList
            [ UIKit.inline
                [ text "Replace the "
                , UIKit.inlineCode "TODO"
                , text " with another placeholder:"
                , UIKit.spacer
                , UIKit.inlineCodeBlock "type alias Msg = ()"
                ]
            , text "Refresh the page."
            ]
      ]

    -----------------------------------------
    -----------------------------------------
    -----------------------------------------
    , [ UIKit.h2 "⛩"
      , UIKit.list
            [ UIKit.inline
                [ text "Second lesson, "
                , UIKit.colored Color.red [ UIKit.boldText "Functions" ]
                , text "."
                ]
            , UIKit.inline
                [ text "The compiler is now saying something is wrong with our "
                , UIKit.inlineCode "main"
                , text " program."
                ]
            , UIKit.inline
                [ text "It's expecting a "
                , UIKit.inlineCode "Program"
                , text ", not a "
                , UIKit.inlineCode "something -> Program"
                , text "."
                ]
            , strong
                []
                [ text "The "
                , UIKit.inlineCode "->"
                , text " arrow indicates a function."
                ]
            , UIKit.inlineCodeBlock "input -> more_input -> output"
            ]
      ]

    -----------------------------------------
    -----------------------------------------
    -----------------------------------------
    , [ UIKit.h2 "⛩"
      , UIKit.list
            [ UIKit.inline
                [ text "Now that we know what the "
                , UIKit.inlineCode "->"
                , text " is,"
                , lineBreak
                , text "we know that "
                , UIKit.inlineCode "Browser.sandbox"
                , text " is a function and"
                , lineBreak
                , text "we should pass it the "
                , UIKit.inlineCode "something"
                , text " value."
                ]
            , chunk
                [ T.measure_narrow ]
                [ UIKit.subtleText """
                  Ok great, but why doesn't it tell us that straight away?
                  Well, there's a reason for that.
                  """
                ]
            , chunk
                [ T.measure_narrow ]
                [ text """
                  You can do a bunch of things with functions.
                  One of them being, partial application.
                  Which means
                  """
                , UIKit.boldText "you can call a function without "
                , UIKit.boldText "passing all the arguments it needs"
                , text "."
                ]
            , UIKit.smallText "(besides, pretty much is everything is a function anyway)"
            ]
      ]

    -----------------------------------------
    -----------------------------------------
    -----------------------------------------
    , [ UIKit.h2 "⛩"
      , UIKit.list
            [ text "What do functions look like anyway?"
            , UIKit.code """
              functionName : a -> b -> Output
              functionName inputA inputB =
                output
              """
            , text "Or anonymous functions:"
            , UIKit.code """
              \\input -> output
              """
            ]
      ]

    -----------------------------------------
    -----------------------------------------
    -----------------------------------------
    , [ UIKit.h2 "⛩"
      , UIKit.list
            [ strong
                []
                [ text "What's this "
                , UIKit.inlineCode "|>"
                , text " thingy?"
                ]
            , UIKit.inline
                [ text "Saying "
                , UIKit.inlineCode "arg |> func"
                , text " is the same as "
                , UIKit.inlineCode "func arg"
                , text "."
                ]
            , text "It becomes useful when chaining multiple function calls."
            , UIKit.code
                """
                argument
                    |> firstFunction
                    |> secondFunction
                """
            ]
      ]

    -----------------------------------------
    -----------------------------------------
    -----------------------------------------
    , [ UIKit.h2 "⛩"
      , UIKit.list
            [ UIKit.inline
                [ text "By the way, "
                , UIKit.boldText "these too are functions"
                , text "."
                , lineBreak
                , text "It just so happens they don't have any parameters."
                ]
            , UIKit.code
                """
                person : Person
                person = { … }
                """
            ]
      ]

    -----------------------------------------
    -----------------------------------------
    -----------------------------------------
    , [ UIKit.h2 "To do"
      , UIKit.orderedList
            [ UIKit.inline
                [ text "The compiler tells us exactly what the "
                , UIKit.inlineCode "Browser.sandbox"
                , text " function needs:"
                , UIKit.spacer
                , let
                    subject label =
                        span
                            [ classes [ T.dib, T.fs_normal, T.fw5, T.w5 ] ]
                            [ text label ]
                  in
                  chunk
                    [ T.f4, T.i ]
                    [ subject "🌳\u{2002}init"
                    , UIKit.subtleText "What is our initial Model?"
                    , lineBreak
                    , subject "📣\u{2002}update"
                    , UIKit.subtleText "How do we update our Model when we receive a Msg?"
                    , lineBreak
                    , subject "🗺\u{2002}view"
                    , UIKit.subtleText "How do we translate our Model into Html?"
                    ]
                , UIKit.spacer
                ]
            , UIKit.inline
                [ text "Try to implement the "
                , UIKit.inlineCode "🌳\u{202F}init"
                , text " and "
                , UIKit.inlineCode "📣\u{202F}update"
                , text " functions."
                , lineBreak
                , UIKit.small
                    [ text "init will be a function of the type "
                    , UIKit.inlineCode "Model"
                    , lineBreak
                    , text "update will be a function of the type "
                    , UIKit.inlineCode "Msg -> Model -> Model"
                    ]
                ]
            , UIKit.inline
                [ text "Uncomment the "
                , UIKit.inlineCode "🗺\u{202F}view"
                , text " function."
                ]
            , UIKit.inline
                [ text "Put everything together in a record as described by "
                , text "the compiler error message."
                , lineBreak
                , UIKit.smallText "Use the functions you just created."
                ]
            , UIKit.inline
                [ text "Save your changes, refresh the page and you should see a \u{1F98A}" ]
            ]
      ]

    -----------------------------------------
    -----------------------------------------
    -----------------------------------------
    , [ UIKit.h2 "Game engine"
      , UIKit.prelude
            [ text "Not much exciting on the screen yet."
            , lineBreak
            , text "Let's change that. Progression:"
            ]
      , UIKit.list
            [ UIKit.inlineCode "Game.render0"
            , UIKit.inlineCode "Game.render1"
            , UIKit.inlineCode "Game.render2"
            , UIKit.inlineCode "Game.render3"
            , UIKit.inlineCode "Game.render4"
            , UIKit.inlineCode "Game.render5"
            ]
      ]

    -----------------------------------------
    -----------------------------------------
    -----------------------------------------
    , [ UIKit.h2 "🗺"
      , UIKit.orderedList
            [ UIKit.inline
                [ text "Import the "
                , UIKit.inlineCode "Game"
                , text " module."
                ]
            , UIKit.inline
                [ text "Use the "
                , UIKit.inlineCode "render0"
                , text " function in your view, replacing "
                , UIKit.inlineCode "Html.div"
                , text "."
                ]
            , text "Refresh to see the Pokémon world."
            ]
      ]

    -----------------------------------------
    -----------------------------------------
    -----------------------------------------
    , [ UIKit.h2 "Where's our trainer?"
      , UIKit.prelude
            [ text "We should make it a bit more interesting,"
            , lineBreak
            , text "add a Pokémon trainer."
            ]
      , UIKit.orderedList
            [ UIKit.inline
                [ text "Progress to the "
                , UIKit.inlineCode "🗺\u{202F}render1"
                , text " function."
                ]
            , text "Try to compile your code."
            , text "Learn about the missing piece by reading the game engine documentation."
            , UIKit.inline
                [ text "Import the missing module."
                , lineBreak
                , UIKit.smallText "Optionally, you can expose the things you need."
                ]
            , UIKit.inline
                [ text "Add the missing piece to your "
                , UIKit.inlineCode "🌳\u{202F}Model"
                , text " by making it a record."
                ]
            , UIKit.inline
                [ text "Use the model parameter in your "
                , UIKit.inlineCode "🗺\u{202F}view"
                , text "."
                ]
            , UIKit.inline
                [ text "Try to compile again and make the necessary adjustments."
                ]
            ]
      ]

    -----------------------------------------
    -----------------------------------------
    -----------------------------------------
    , [ UIKit.h2 "Can we make her move?"
      , UIKit.prelude
            [ text "Part I, adjusting the main function."
            ]
      , UIKit.orderedList
            [ UIKit.inline
                [ text "Upgrade to "
                , UIKit.inlineCode "Browser.element"
                , text ", replacing "
                , UIKit.inlineCode "Browser.sandbox"
                , text "."
                , lineBreak
                , UIKit.small
                    [ text "This introduces subscriptions, which allow you to subscribe to events."
                    , lineBreak
                    , text "In this case we want to "
                    , UIKit.boldText "subscribe to keyboard events"
                    , text "."
                    ]
                ]
            , UIKit.inline
                [ text "Replace the "
                , UIKit.inlineCode "📰\u{202F}TODO"
                , text " with a "
                , UIKit.inlineCode "subscriptions"
                , text " function."
                , lineBreak
                , UIKit.small
                    [ text "You can use "
                    , UIKit.inlineCode "Sub.none"
                    , text " as a placeholder."
                    , lineBreak
                    , text "See the "
                    , UIKit.link
                        { label = "Platform.Sub documentation"
                        , url = "https://package.elm-lang.org/packages/elm/core/latest/Platform-Sub#none"
                        }
                    , text " for more info."
                    ]
                ]
            , UIKit.inline
                [ text "Adjust the first argument passed to"
                , UIKit.inlineCode "Browser.element"
                , lineBreak
                , text " and the referenced functions, then try to compile."
                , lineBreak
                , UIKit.small
                    [ text "You'll need "
                    , UIKit.inlineCode "Cmd"
                    , text " as well, which is the counterpart of "
                    , UIKit.inlineCode "Sub"
                    , text "."
                    , lineBreak
                    , text "The placeholder for those is "
                    , UIKit.inlineCode "Cmd.none"
                    , text "."
                    , lineBreak
                    , text "See the "
                    , UIKit.link
                        { label = "Browser.element documentation"
                        , url = "https://package.elm-lang.org/packages/elm/browser/latest/Browser#element"
                        }
                    , text " for more info."
                    ]
                ]
            ]
      ]

    -----------------------------------------
    -----------------------------------------
    -----------------------------------------
    , [ UIKit.prelude
            [ text "Part II, messages."
            ]
      , UIKit.orderedList
            [ UIKit.inline
                [ text "Import the "
                , UIKit.inlineCode "Keyboard"
                , text " module."
                ]
            , UIKit.inline
                [ UIKit.code """
                    -- 🌳
                    type Msg
                      = ArrowKeyPressed Keyboard.ArrowKey
                      | Ignore
                  """
                , UIKit.spacer
                , UIKit.smallText "Change Msg to a set of things that can happen in our app."
                ]
            , UIKit.inline
                [ text "The messages produced by the "
                , UIKit.inlineCode "🗺\u{202F}Game.render1"
                , text " function are"
                , lineBreak
                , text "no longer the same as our own. "
                , UIKit.spacer
                , UIKit.code """
                    view _ = Html.map (always Ignore) (Game.render1 …)
                  """
                , UIKit.spacer
                , UIKit.smallText "So we'll have to map from a to b."
                ]
            ]
      ]

    -----------------------------------------
    -----------------------------------------
    -----------------------------------------
    , [ UIKit.prelude
            [ text "Part III, subscribe and update using messages."
            ]
      , UIKit.orderedList
            [ UIKit.inline
                [ text "Replace "
                , UIKit.inlineCode "📰\u{202F}Sub.none"
                , text " with the `down` function from the "
                , UIKit.inlineCode "Keyboard"
                , text " module."
                , lineBreak
                , UIKit.smallText "Pass it the function that produces your keyboard message."
                , lineBreak
                , UIKit.smallText "In other words, your keyboard message without any arguments."
                ]
            , UIKit.inline
                [ text "Rewrite your "
                , UIKit.inlineCode "📣\u{202F}update"
                , text " function so that you can handle the incoming messages:"
                , UIKit.spacer
                , UIKit.code """
                    update msg model =
                      case msg of
                        -- TELEPORT!
                        ArrowKeyPressed key ->
                          ({ model | characterPosition = { x = 8, y = 7 }}, Cmd.none)
                  """
                , UIKit.spacer
                , UIKit.smallText "This is called pattern matching"
                ]
            , UIKit.inline
                [ text "Try to compile and make adjustments."
                , lineBreak
                , UIKit.small
                    [ text "The case statement in update needs another branch."
                    , lineBreak
                    , text "Also, make sure your "
                    , UIKit.inlineCode "🗺\u{202F}view"
                    , text " is using the correct data."
                    ]
                ]
            , UIKit.boldText "Pressing any arrow key will now teleport your character!"
            ]
      ]

    -----------------------------------------
    -----------------------------------------
    -----------------------------------------
    , [ UIKit.prelude
            [ text "Part IV. Ok cool, for real now please."
            ]
      , UIKit.orderedList
            [ UIKit.inline
                [ text "Import the "
                , UIKit.inlineCode "Character"
                , text " module and expose the direction type and all its values:"
                , UIKit.spacer
                , UIKit.code """
                    import Character exposing (Direction(..))
                  """
                , UIKit.spacer
                , UIKit.small
                    [ text "This'll expose the Direction type and all its values."
                    , lineBreak
                    , text "You can do the same for the "
                    , UIKit.inlineCode "Keyboard.ArrowKey"
                    , text " type."
                    ]
                ]
            , UIKit.inline
                [ text "Read the "
                , UIKit.inlineCode "Character.move"
                , text " function documentation."
                ]
            , UIKit.inline
                [ text "Try to use that in your "
                , UIKit.inlineCode "📣\u{202F}update"
                , text " function."
                , lineBreak
                , UIKit.small
                    [ text "Tips:"
                    , lineBreak
                    , text "•\u{202F} This is a great time to check out "
                    , UIKit.link
                        { label = "let expressions/blocks"
                        , url = "https://elm-lang.org/docs/syntax#let-expressions"
                        }
                    , text "."
                    , lineBreak
                    , text "•\u{202F} Write a helper function to translate "
                    , text "a "
                    , UIKit.inlineCode "Keyboard.ArrowKey"
                    , text " into a "
                    , UIKit.inlineCode "Character.Direction"
                    , text "."
                    , lineBreak
                    , text "•\u{202F} Make sure the new character position is used in the resulting/new model."
                    ]
                ]
            , UIKit.boldText "Run around for reals!"
            ]
      ]

    -----------------------------------------
    -----------------------------------------
    -----------------------------------------
    , [ UIKit.h2 "Walking animation"
      , UIKit.prelude
            [ text "Ok, we got a difficult part out of the way, time for something easy."
            , lineBreak
            , text "How about we make it a bit more spicy by adding some animation?"
            ]
      , UIKit.orderedList
            [ UIKit.inline
                [ text "Add "
                , UIKit.inlineCode "characterWalkCycle : Character.WalkCycle"
                , text " to your "
                , UIKit.inlineCode "🌳\u{202F}Model"
                , text "."
                , lineBreak
                , UIKit.smallText "This is the state for the animation."
                , lineBreak
                , UIKit.smallText "No need to worry about the implementation."
                ]
            , UIKit.inline
                [ text "Update your "
                , UIKit.inlineCode "🌳\u{202F}init"
                , text " function to reflect the Model type change."
                , lineBreak
                , text "You can use "
                , UIKit.inlineCode "Character.initialWalkCycle Down"
                , text " as the initial value."
                ]
            , UIKit.inline
                [ text "Check the "
                , UIKit.inlineCode "Character.walk"
                , text " docs and use it in your "
                , UIKit.inlineCode "📣\u{202F}update"
                , text " function."
                , lineBreak
                , UIKit.smallText "Just like we did with the move function."
                ]
            , UIKit.inline
                [ text "Upgrade "
                , UIKit.inlineCode "🗺\u{202F}Game.render1"
                , text " to "
                , UIKit.inlineCode "🗺\u{202F}Game.render2"
                , text "."
                ]
            , UIKit.boldText "Compile & walk around to check out the animation."
            ]
      ]

    -----------------------------------------
    -----------------------------------------
    -----------------------------------------
    , [ UIKit.h2 "Some pokémon please!"
      , UIKit.orderedList
            [ UIKit.inlineCode "import Pokemon exposing (Pokemon(..))"
            , UIKit.inline
                [ text "Keep track of which Pokémon you want to show"
                , lineBreak
                , text "and if you want to show one at all."
                , UIKit.spacer
                , UIKit.code """
                    type alias Model =
                      { shownPokemon : Maybe Pokemon }
                  """
                , UIKit.spacer
                ]
            , UIKit.inline
                [ text "Make changes to reflect the "
                , UIKit.inlineCode "🌳\u{202F}Model"
                , text " changes."
                ]
            , UIKit.inline
                [ text "Upgrade "
                , UIKit.inlineCode "🗺\u{202F}Game.render2"
                , text " to "
                , UIKit.inlineCode "🗺\u{202F}Game.render3"
                , text ","
                , lineBreak
                , text " and then pass it the "
                , UIKit.inlineCode "Maybe Pokemon"
                , text " value."
                ]
            , UIKit.boldText "Refresh to see your selected Pokémon."
            ]
      ]

    -----------------------------------------
    -----------------------------------------
    -----------------------------------------
    , [ UIKit.h2 "Walk around to find Pokémon"
      , UIKit.list
            [ UIKit.inline
                [ text "Instead of directly showing a Pokémon"
                , lineBreak
                , text "we should add some logic that randomly shows one"
                , lineBreak
                , text "when you walk around in the high grass."
                , lineBreak
                , lineBreak
                ]
            , UIKit.inline
                [ text "We need two things for this:"
                , lineBreak
                , text "A time factor "
                , text "& grass detection."
                , lineBreak
                , lineBreak
                ]
            , UIKit.inline
                [ text "I wrote the grass detection code for you,"
                , lineBreak
                , UIKit.boldText "adding the time factor is up to you"
                , text "."
                ]
            ]
      ]

    -----------------------------------------
    -----------------------------------------
    -----------------------------------------
    , [ UIKit.h2 "Listen to time"
      , UIKit.orderedList
            [ UIKit.inline
                [ text "Import the "
                , UIKit.inlineCode "Time"
                , text " and "
                , UIKit.inlineCode "World"
                , text " modules."
                ]
            , UIKit.inline
                [ text "Add a "
                , UIKit.inlineCode "📣\u{202F}Msg"
                , text " that will store a "
                , UIKit.inlineCode "Time.Posix"
                , text " value "
                , text " in your "
                , UIKit.inlineCode "🌳\u{202F}Model"
                , text "."
                ]
            , UIKit.inline
                [ text "Extend your "
                , UIKit.inlineCode "🌳\u{202F}Model"
                , text " and "
                , UIKit.inlineCode "📣\u{202F}update"
                , text " function."
                , lineBreak
                , UIKit.small
                    [ text "See the "
                    , UIKit.link
                        { label = "elm/time documentation"
                        , url = "https://package.elm-lang.org/packages/elm/time/latest/Time#millisToPosix"
                        }
                    , text " on what the initial value should be."
                    ]
                ]
            , UIKit.inline
                [ text "Subscribe to the flow of time: "
                , UIKit.inlineCode """Time.every 500 YourNewMsgGoesHere"""
                , lineBreak
                , UIKit.small
                    [ text "You must use "
                    , UIKit.inlineCode "Sub.batch"
                    , text " to combine multiple subscriptions."
                    ]
                ]
            , UIKit.inline
                [ text "Using the "
                , UIKit.inlineCode "Pokemon.basedOnTime"
                , text " and "
                , UIKit.inlineCode "World.anyHighGrassAt"
                , text " functions,"
                , lineBreak
                , text "try to make it so that"
                , text " Pokémon randomly appear when you walk through the grass."
                ]
            , UIKit.boldText "Walk around to find Pokémon!"
            ]
      ]

    -----------------------------------------
    -----------------------------------------
    -----------------------------------------
    , [ UIKit.h2 "Gotta catch em' all"
      , UIKit.prelude
            [ text "Our game is stuck on the Pokémon screen."
            , lineBreak
            , text "How do we use the Pokéball?"
            ]
      , UIKit.orderedList
            [ UIKit.inline
                [ text "Add a "
                , UIKit.inlineCode "📣\u{202F}Msg"
                , text " to catch our Pokémon."
                , lineBreak
                , UIKit.smallText "Or in other words, to use the Pokéball."
                , lineBreak
                , UIKit.smallText "This Msg shouldn't have any parameters."
                ]
            , UIKit.inline
                [ text "Upgrade "
                , UIKit.inlineCode "🗺\u{202F}Game.render3"
                , text " to "
                , UIKit.inlineCode "🗺\u{202F}Game.render4"
                , text ","
                , lineBreak
                , text " and then pass it the "
                , UIKit.inlineCode "📣\u{202F}Msg"
                , text " value you just created."
                ]
            , UIKit.inline
                [ text "Remove the "
                , UIKit.inlineCode "Html.map"
                , text " bit in your view."
                ]
            , UIKit.inline
                [ text "Define the logic in your "
                , UIKit.inlineCode "📣\u{202F}update"
                , text " function."
                , lineBreak
                , UIKit.small
                    [ text "Hint, do something with "
                    , UIKit.inlineCode "shownPokemon"
                    , text "."
                    ]
                ]
            , UIKit.boldText "Catch some Pokémon!"
            ]
      ]

    -----------------------------------------
    -----------------------------------------
    -----------------------------------------
    , [ UIKit.h2 "Extra"
      , UIKit.prelude
            [ text "As an extra you can show the Pokéball animation."
            ]
      , UIKit.orderedList
            [ UIKit.inline
                [ text "Upgrade "
                , UIKit.inlineCode "🗺\u{202F}Game.render4"
                , text " to "
                , UIKit.inlineCode "🗺\u{202F}Game.render5"
                , text "."
                ]
            , UIKit.inline
                [ text "Read all the docs from the "
                , UIKit.inlineCode "Game"
                , text " module."
                ]
            , UIKit.inline
                [ text "Keep those "
                , UIKit.inlineCode "Game.Options"
                , text " in your model."
                ]
            , UIKit.inline
                [ text "Read about "
                , UIKit.link
                    { label = "tasks"
                    , url = "https://package.elm-lang.org/packages/elm/core/latest/Task"
                    }
                , text " and "
                , UIKit.link
                    { label = "processes"
                    , url = "https://package.elm-lang.org/packages/elm/core/latest/Process"
                    }
                , text "."
                , lineBreak
                , UIKit.small
                    [ text "Notice that tasks output "
                    , UIKit.inlineCode "Cmd"
                    , text "s."
                    ]
                ]
            , chunk
                [ T.dib, T.measure, T.v_top ]
                [ text "When you use a Pokéball "
                , UIKit.smallText "(msg you passed to Game.render)"
                , text ","
                , lineBreak
                , text " try to send a "
                , UIKit.inlineCode "Msg"
                , text " after the Pokéball animation is finished."
                , lineBreak
                , UIKit.small
                    [ text "You can get the animation duration using "
                    , UIKit.inlineCode "Pokemon.ballAnimationDuration"
                    , text ", and send a delayed message using Elm's "
                    , UIKit.inlineCode "Process.sleep"
                    , text " and "
                    , UIKit.inlineCode "Task.perform"
                    , text "."
                    ]
                ]
            , UIKit.inline
                [ text "Add the logic for the "
                , UIKit.inlineCode "cacheBuster"
                , text ", to reset the animation."
                ]
            ]
      ]

    -----------------------------------------
    -----------------------------------------
    -----------------------------------------
    , [ UIKit.h1_end "The End"

      -- Mew!
      , UIKit.pixelatedImage
            [ src "/assets/pokemon/151.gif"
            , width 275
            ]
      ]
    ]
