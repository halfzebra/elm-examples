module Components.Form.Field exposing (..)

import Html exposing (text, div, input, button, Html)
import Html.Attributes exposing (value)
import Html.Events exposing (onClick, onInput)


type alias Model =
    String


type Internal
    = Update String


type Outcoming
    = Remove


type Msg
    = InMsg Internal
    | OutMsg Outcoming


type alias Dictionary parentMsg =
    { onInternalMessage : Internal -> parentMsg
    , onOutcomingMessage : Outcoming -> parentMsg
    }


type alias Translator parentMsg =
    Msg -> parentMsg


translator : Dictionary parentMsg -> Translator parentMsg
translator { onInternalMessage, onOutcomingMessage } msg =
    case msg of
        InMsg internal ->
            onInternalMessage internal

        OutMsg outcoming ->
            onOutcomingMessage outcoming


update : Internal -> Model -> Model
update msg model =
    case msg of
        Update val ->
            val


view : Model -> Html Msg
view model =
    div []
        [ input [ onInput (InMsg << Update), value model ] []
        , button [ onClick (OutMsg Remove) ] [ text "Remove" ]
        ]
