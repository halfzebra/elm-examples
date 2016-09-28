# Module composition in Elm

This example features the simplest way for establishing module communication.

[@rtfeldman](https://github.com/rtfeldman/) on [Design of Large Elm apps](https://groups.google.com/forum/#!msg/elm-discuss/_cfOu88oCx4/6tVXN2TGAgAJ)

> The first three things you should reach for are, in no particular order:
> - Splitting `view` into smaller functions (without reorganizing `Model` or `update`)
> - Splitting `Model` into smaller values (without reorganizing `view` or `update`)
> - Splitting `update` into smaller functions (without reorganizing `Model` or `view`)
>
> Do one of these 3 things, one at a time, over and over, until either you're thinking "I need to split out some of this to reuse it elsewhere" (in which case you enter the realm of API design, and there is no one-size-fits-all answer to what you should do next), or you find yourself thinking "even after these small refactors, there is a big chunk of code that still feels unwieldy, and it's self-contained enough that I could separate it out into essentially its own little application, and have it communicate with the rest of the application, and that communication overhead sounds like it would be worth it."

## Motivation

Elm implements uni-directional message passing,
so you can not send a message directly from child to parent.

To mimic child-to-parent message passing, we have to send a message from the
child and [capture it in parent's update](Main.elm#L61) function.

While [Input](Input.elm#L21) module has defined more than one message, only `Update`
will have effect on the state.

```elm
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Update value ->
            ( value, Cmd.none )

        -- Ignore the rest of the messages.
        _ ->
            ( model, Cmd.none )
```

## Building the example

```sh
$ elm-package install -y
$ elm-make Main.elm
```

## More information on module composition in Elm

For more ideas, I highly recommend watching [API Design Session - elm-autocomplete with Greg Ziegan](https://www.youtube.com/watch?v=KSuCYUqY058)