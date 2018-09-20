module App.View exposing (view)

import App.Counter.View
import App.Messages exposing (..)
import App.Model exposing (Model)
import Html exposing (Html, div, text)


view : Model -> Html Msg
view model =
    div []
        [ text "Try pressing up & down arrow keys on keyboard"
        , Html.map CounterMsg (App.Counter.View.view model.counter)
        ]
