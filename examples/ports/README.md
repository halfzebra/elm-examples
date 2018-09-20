# JavaScript interop with Elm

This is an example of passing messages from Elm to JavaScript and backwards.

It sends a hole `()` or empty Tuple to JavaScript, as a message and retrieves a numeric value.

Inspired by [Trouble Connecting Ports and Subscriptions] [question]

See more on the matter in the official docs for [JavaScript Interop] [ports]

## Building the example

Since this example features port module, it is impossible to build it with `elm reactor`.

You have to explicitly specify the `--output=index.js`

```sh
$ elm make Main.elm --output=index.js
```

[ports]: <https://guide.elm-lang.org/interop/ports.html>
[question]: <http://stackoverflow.com/questions/37586991/trouble-connecting-ports-and-subscriptions/>
