module Main exposing (main)

import App.Messages exposing (Msg)
import App.Model exposing (Flags, Model, init)
import App.Subscriptions exposing (subscriptions)
import App.Update exposing (update)
import App.View exposing (view)
import Browser


main : Program Flags Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
