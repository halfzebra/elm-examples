module App.Model exposing (..)

import App.Messages exposing (Msg)
import Components.Counter.Model


type alias Model =
    { dev : Bool
    , counter : Components.Counter.Model.Model
    }


type alias Flags =
    { dev : Bool
    , counter : Int
    }


init : Flags -> ( Model, Cmd Msg )
init flags =
    let
        { dev, counter } =
            flags
    in
        ( Model dev counter, Cmd.none )
