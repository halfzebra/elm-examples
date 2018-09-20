module App.Subscriptions exposing (subscriptions)

import App.Counter.Subscriptions
import App.Messages exposing (..)
import App.Model exposing (Model)


{-| This is how you can organize subscribtions from child modules.
-}
subscriptions : Model -> Sub Msg
subscriptions model =
    let
        counterSub =
            App.Counter.Subscriptions.subscriptions model.counter
    in
    Sub.batch [ Sub.map CounterMsg counterSub ]
