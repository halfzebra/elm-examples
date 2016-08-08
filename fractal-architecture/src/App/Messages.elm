module App.Messages exposing (Msg(..))

import Components.Counter.Messages


type Msg
    = NoOp
    | CounterMsg Components.Counter.Messages.Msg
