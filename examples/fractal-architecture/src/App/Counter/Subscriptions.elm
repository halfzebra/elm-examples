module App.Counter.Subscriptions exposing (..)

import Keyboard
import App.Counter.Model exposing (..)
import App.Counter.Messages exposing (..)


subscriptions : Model -> Sub Msg
subscriptions model =
    Keyboard.downs Keydown
