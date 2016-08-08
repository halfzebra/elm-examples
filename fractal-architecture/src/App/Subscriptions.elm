module App.Subscriptions exposing (..)

import App.Model exposing (Model)
import App.Messages exposing (..)
import Components.Counter.Subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    let
        counterSub =
            Components.Counter.Subscriptions.subscriptions model.counter
    in
        Sub.batch [ Sub.map Counter counterSub ]
