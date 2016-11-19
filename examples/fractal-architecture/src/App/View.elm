module App.View exposing (..)

import Html
import Html exposing (text, div, Html)
import App.Model exposing (Model)
import App.Messages exposing (..)
import App.Counter.View


view : Model -> Html Msg
view model =
    div []
        [ text "Try pressing up & down arrow keys on keyboard"
        , Html.map CounterMsg (App.Counter.View.view model.counter)
        ]
