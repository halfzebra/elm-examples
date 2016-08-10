# Parent-child communication in Elm

This example features the simpliest way for establishing parent-child communication.

Elm implements uni-directional message passing,
so you can not send a message directly from child to parent.

To mimic child-to-parent message passing, we have to send a message from the
child and [capture it in parent's update](Main.elm#L61) function.

While [Input](Input.elm#L21) component defined more than one message, only `Update`
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