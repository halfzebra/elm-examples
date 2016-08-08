module App.Update exposing (..)

import Utils exposing (log)
import App.Model exposing (Model)
import App.Messages exposing (..)
import Components.Counter.Messages
import Components.Counter.Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        logMsg =
            log model.dev "MESSAGE: "
    in
        case (logMsg msg) of
            NoOp ->
                ( model, Cmd.none )

            Counter counterMsg ->
                let
                    ( counterModel, counterCmd ) =
                        Components.Counter.Update.update counterMsg model.counter
                in
                    ( { model
                        | counter = counterModel
                      }
                    , Cmd.map Counter counterCmd
                    )
