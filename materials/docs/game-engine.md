# Game Engine Documentation

Modules:
- Character
- Game
- Geometry
- Keyboard
- Pokemon
- World



## Character

### Types & Aliases

```elm
type Direction
  = Up
  | Down
  | Left
  | Right
```

4 Directional.

```elm
type alias WalkCycle =
  { direction : Character.Direction
  , duration : Int
  , index : Int
  }
```

The walk-cycle animation.


### Functions & Constants

```elm
move : Character.Direction -> Geometry.Coordinates -> Geometry.Coordinates
```

Move the character in one direction.

```elm
initialWalkCycle : Character.Direction -> Character.WalkCycle
```

Generate an initial walkcycle based on a given direction.

```elm
walk : Character.Direction -> Character.WalkCycle -> Character.WalkCycle
```

Update the character's walkcycle based on a given walking direction.



## Game

### Types & Aliases

```elm
type alias Options =
  { cacheBuster : Int
  , showPokeball : Bool
  }
```

The last parameter of the last `render` function.
Allows you to show a Pokéball on the screen.

The `cacheBuster` is necessary to reset the gif animation.
Ideally this value increases each time you show a Pokémon.
This could, for example, be the length of the list of Pokémon you caught.
Assuming you catch every Pokémon you encounter that is.


### Functions & Constants

```elm
render0 : Html ()
render1 : Geometry.Coordinates -> Html ()
render2 : Geometry.Coordinates -> Character.WalkCycle -> Html ()
render3 : Geometry.Coordinates -> Character.WalkCycle -> Maybe Pokemon -> Html ()
render4 : Geometry.Coordinates -> Character.WalkCycle -> Maybe Pokemon -> msg -> Html msg
render5 : Geometry.Coordinates -> Character.WalkCycle -> Maybe Pokemon -> msg -> Game.Options -> Html msg
```

Render the game.

Important notes:
- The `msg` is sent each time you click on "Use Pokéball".
- If you want to use `render5`, make sure to read the docs on the `Options` type alias above.




## Geometry

### Types & Aliases

```elm
type alias Coordinates =
  { x : Basics.Int
  , y : Basics.Int
  }
```

2D Coordinates.
For example, `characterPosition = { x = 8, y = 7 }`.



## Keyboard

### Types & Aliases

```elm
type ArrowKey
  = ArrowUp
  | ArrowDown
  | ArrowLeft
  | ArrowRight
```

A set of arrow keys from your keyboard.


### Functions & Constants

```elm
onArrowKeyDown : (Keyboard.ArrowKey -> msg) -> Sub msg
```

Subscribe to "downs" of arrow keys.

```elm
onArrowKeyUp : (Keyboard.ArrowKey -> msg) -> Sub msg
```

Subscribe to "ups" of arrow keys.



## Pokemon

### Types & Aliases

```elm
type Pokemon
  = Charmander
  | Dragonair
  | Mew
  | Pikachu
  | Snorlax
```

The Pokémon.


### Functions & Constants

```elm
ballAnimationDuration : Float
```

The duration of the Pokéball gif in milliseconds.

```elm
basedOnTime : Time.Posix -> Maybe Pokemon
```

Maybe present a Pokémon, based on time.



## World

### Functions & Constants

```elm
anyHighGrassAt : Geometry.Coordinates -> Bool
```

High-grass detection.
