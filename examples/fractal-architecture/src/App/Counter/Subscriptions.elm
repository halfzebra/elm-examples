module Components.Counter.Subscriptions exposing (..)

import Keyboard
import Components.Counter.Model exposing (..)
import Components.Counter.Messages exposing (..)


subscriptions : Model -> Sub Msg
subscriptions model =
    Keyboard.downs Keydown
