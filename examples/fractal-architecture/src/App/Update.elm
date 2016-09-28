module App.Update exposing (..)

import Utils exposing (log)
import App.Model exposing (Model)
import App.Messages exposing (..)
import App.Counter.Messages
import App.Counter.Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        logMsg =
            log model.dev "MESSAGE: "
    in
        case (logMsg msg) of
            NoOp ->
                ( model, Cmd.none )

            CounterMsg counterMsg ->
                let
                    ( counterModel, counterCmd ) =
                        App.Counter.Update.update counterMsg model.counter
                in
                    ( { model | counter = counterModel }
                    , Cmd.map CounterMsg counterCmd
                    )
