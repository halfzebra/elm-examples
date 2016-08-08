module Components.Counter.Update exposing (..)

import Components.Counter.Model exposing (..)
import Components.Counter.Messages exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Up ->
            ( model + 1, Cmd.none )

        Down ->
            ( model - 1, Cmd.none )

        Keydown code ->
            case code of
                38 ->
                    update Up model

                40 ->
                    update Down model

                _ ->
                    ( model, Cmd.none )
