module App.Messages exposing (..)

import Components.Counter.Messages


type Msg
    = NoOp
    | Counter Components.Counter.Messages.Msg
