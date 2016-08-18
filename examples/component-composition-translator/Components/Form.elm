module Components.Form exposing (..)

import Html exposing (text, Html)
import Html.App
import Components.Form.Field


-- MODEL


type alias Model =
    { field : Components.Form.Field.Model
    , isSubmitted : Bool
    }


init : Model
init =
    { field = ""
    , isSubmitted = False
    }



-- Translator wiring for parent component.
-- Define a Record with a shape of a Dictionary from Components.Form.Field


fieldDictionary : Components.Form.Field.Dictionary Msg
fieldDictionary =
    { onInternalMessage = FieldMsg
    , onOutcomingMessageSubmit = Submit
    }


{-| Partially apply Components.Form.Field.translator function
    to carry message mappings from fieldDictionary Record
-}
fieldTranslator : Components.Form.Field.Translator Msg
fieldTranslator =
    Components.Form.Field.translator fieldDictionary


type Msg
    = FieldMsg Components.Form.Field.Internal
    | Submit


update : Msg -> Model -> Model
update msg model =
    case msg of
        -- Run update routine for child component as usual.
        FieldMsg inMsg ->
            { model | field = Components.Form.Field.update inMsg model.field }

        Submit ->
            { model | isSubmitted = True }


view : Model -> Html Msg
view model =
    if model.isSubmitted == False then
        Html.App.map fieldTranslator (Components.Form.Field.view model.field)
    else
        text
            """
            Congratulations!
            You have succesefuly submitted the form,
            written in Elm using Translator pattern.
            """
