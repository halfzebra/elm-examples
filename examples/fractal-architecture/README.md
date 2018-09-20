# Elm Fractal Architecture example

An example of Elm project organisation with a self-resembling architecture.

Compose View, Update, Message, Model, Subscriptions and Commands with Fractal Architecture.

Features:
- Module splitting
- Usage of `Browser.element`
- Module composition
- [Subscription batching](src/App/Subscriptions.elm) for subscribing to `Keyboard` messages from child modules

## Building the example

Since this example features `Browser.element` usage, it is impossible to build it with `elm reactor`.

You have to explicitly specify the `--output=index.js`

```sh
$ elm make src/Main.elm --output=index.js
```
