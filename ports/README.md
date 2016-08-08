### JavaScript interop with Elm

This is an example of passing messages from Elm to JavaScript and backwards.

Inspired by [Trouble Connecting Ports and Subscriptions] [question]

See more on the matter in the official docs for [JavaScript Interop] [ports]

### To run:
```sh
$ elm-package istall -y
$ elm-make Main.elm --output=index.js
```

[ports]: <http://guide.elm-lang.org/interop/javascript.html>
[question]: <http://stackoverflow.com/questions/37586991/trouble-connecting-ports-and-subscriptions/>