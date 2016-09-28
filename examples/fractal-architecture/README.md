# Elm Fractal Architecture example

An example of Elm project organisation with a self-resembling architecture.

Compose View, Update, Message, Model, Subscriptions and Commands with Fractal Architecture.

Features:
- Module splitting
- Usage of `Html.App.programWithFlags`
- Module composition
- [Subscription batching](examples/fractal-architecture/src/App/Subscriptions.elm) for subscribing to `Keyboard` messages from child modules

## Building the example

Since this example features `Html.App.programWithFlags` usage, it is impossible to build it with [elm-reactor](https://github.com/elm-lang/elm-reactor)

You have to explicitly specify the `--output=index.js`

```sh
$ elm-package install -y
$ elm-make Main.elm --output=index.js
```