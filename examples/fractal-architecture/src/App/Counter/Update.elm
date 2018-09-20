module App.Counter.Update exposing (update)

import App.Counter.Messages exposing (..)
import App.Counter.Model exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Up ->
            ( model + 1, Cmd.none )

        Down ->
            ( model - 1, Cmd.none )

        Keydown code ->
            case code of
                "ArrowUp" ->
                    update Up model

                "ArrowDown" ->
                    update Down model

                _ ->
                    ( model, Cmd.none )
