module Form.Field exposing (Dictionary, Internal(..), Model, Msg(..), Outcoming(..), Tagger, tagger, update, view)

import Html exposing (Html, button, div, input, text)
import Html.Attributes exposing (value)
import Html.Events exposing (onClick, onInput)


type alias Model =
    String


type Internal
    = Update String


type Outcoming
    = Submit


type Msg
    = InMsg Internal
    | OutMsg Outcoming


type alias Dictionary parentMsg =
    { onInternalMessage : Internal -> parentMsg
    , onOutcomingMessageSubmit : parentMsg
    }


type alias Tagger parentMsg =
    Msg -> parentMsg


tagger : Dictionary parentMsg -> Tagger parentMsg
tagger { onInternalMessage, onOutcomingMessageSubmit } msg =
    case msg of
        InMsg internal ->
            onInternalMessage internal

        OutMsg Submit ->
            onOutcomingMessageSubmit


update : Internal -> Model -> Model
update msg model =
    case msg of
        Update val ->
            val


view : Model -> Html Msg
view model =
    div []
        [ input [ onInput (InMsg << Update), value model ] []
        , button [ onClick (OutMsg Submit) ] [ text "Submit" ]
        ]
