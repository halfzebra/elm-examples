# Elm Fractal Architecture example

An example of project organisation with Fractal Architecture.

The key idea is self-repeating structure of it's components.

Features:
- Component splitting
- Usage of `Html.App.programWithFlags`
- Uni-directional message passing to child components
- Subscription passing of `Keyboard` messages to child components

### Building the example

Since this example features `Html.App.programWithFlags` usage, it is impossible to build it with [elm-reactor](https://github.com/elm-lang/elm-reactor)

```sh
$ elm-package istall -y
$ elm-make Main.elm --output=index.js
```