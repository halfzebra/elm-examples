module App.Subscriptions exposing (..)

import App.Model exposing (Model)
import App.Messages exposing (..)
import Components.Counter.Subscriptions


{-| This is how you can organize subscribtions from child components.
-}
subscriptions : Model -> Sub Msg
subscriptions model =
    let
        counterSub =
            Components.Counter.Subscriptions.subscriptions model.counter
    in
        Sub.batch [ Sub.map CounterMsg counterSub ]
