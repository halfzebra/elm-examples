module Components.Form exposing (..)

import Html exposing (Html)
import Html.App
import Components.Form.Field


type alias Model =
    { field : Components.Form.Field.Model
    }


init : Model
init =
    { field = ""
    }


type Msg
    = FieldMsg Components.Form.Field.Internal
    | FormMsg Components.Form.Field.Outcoming


fieldDictionary : Components.Form.Field.Dictionary Msg
fieldDictionary =
    { onInternalMessage = FieldMsg
    , onOutcomingMessage = FormMsg
    }


fieldTranslator : Components.Form.Field.Translator Msg
fieldTranslator =
    Components.Form.Field.translator fieldDictionary


update : Msg -> Model -> Model
update msg model =
    case msg of
        FieldMsg inMsg ->
            { model | field = Components.Form.Field.update inMsg model.field }

        FormMsg outMsg ->
            model


view : Model -> Html Msg
view model =
    Html.App.map fieldTranslator (Components.Form.Field.view model.field)
