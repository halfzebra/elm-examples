module Main exposing (..)

import Html.App
import App.Model exposing (Model)
import App.Messages exposing (Msg)
import App.Update exposing (update)
import App.View exposing (view)
import App.Subscriptions exposing (subscriptions)


main : Program Never
main =
    programWithFlags
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }