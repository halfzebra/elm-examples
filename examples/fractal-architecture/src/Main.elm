module Main exposing (..)

import Html exposing (programWithFlags)
import App.Model exposing (init, Model, Flags)
import App.Messages exposing (Msg)
import App.Update exposing (update)
import App.View exposing (view)
import App.Subscriptions exposing (subscriptions)


main : Program Flags Model Msg
main =
    programWithFlags
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
