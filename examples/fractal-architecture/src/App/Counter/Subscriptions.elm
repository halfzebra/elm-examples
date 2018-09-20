module App.Counter.Subscriptions exposing (subscriptions)

import App.Counter.Messages exposing (..)
import App.Counter.Model exposing (..)
import Browser.Events as Events
import Json.Decode as Decode


subscriptions : Model -> Sub Msg
subscriptions model =
    Events.onKeyDown (Decode.map Keydown keyDecoder)


keyDecoder : Decode.Decoder String
keyDecoder =
    Decode.field "key" Decode.string
