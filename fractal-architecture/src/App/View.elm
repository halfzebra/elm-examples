module App.View exposing (..)

import Html.App
import Html exposing (text, div, Html)
import App.Model exposing (Model)
import App.Messages exposing (Msg)
import Components.Counter.View


view : Model -> Html Msg
view model =
    div []
        [ Html.App.map Counter (Components.Counter.View.view model.counter) ]
