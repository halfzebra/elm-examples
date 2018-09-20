module App.Counter.View exposing (view)

import App.Counter.Messages exposing (..)
import App.Counter.Model exposing (..)
import Debug
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


view : Model -> Html Msg
view model =
    div
        []
        [ button [ onClick Up ] [ text "+" ]
        , text (Debug.toString model)
        , button [ onClick Down ] [ text "-" ]
        ]
