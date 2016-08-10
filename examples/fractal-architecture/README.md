# Elm Fractal Architecture example

An example of project organisation with Fractal Architecture.

The key idea is self-repeating structure of it's components.

Features:
- Component splitting
- Usage of `Html.App.programWithFlags`
- Component composition
- [Subscription batching](examples/fractal-architecture/src/App/Subscriptions.elm) for subscribing to `Keyboard` messages from child components

## Building the example

Since this example features `Html.App.programWithFlags` usage, it is impossible to build it with [elm-reactor](https://github.com/elm-lang/elm-reactor)

You have to explicitly specify the `--output=index.js`

```sh
$ elm-package istall -y
$ elm-make Main.elm --output=index.js
```