module Form exposing (Model, Msg(..), fieldDictionary, fieldMessageTagger, init, update, view)

import Form.Field
import Html exposing (Html, text)



-- MODEL


type alias Model =
    { field : Form.Field.Model
    , isSubmitted : Bool
    }


init : Model
init =
    { field = ""
    , isSubmitted = False
    }



-- Translator wiring for parent module.
-- Define a Record with a shape of a Dictionary from Form.Field


fieldDictionary : Form.Field.Dictionary Msg
fieldDictionary =
    { onInternalMessage = FieldMsg
    , onOutcomingMessageSubmit = Submit
    }


{-| Partially apply Form.Field.translator function
to carry message mappings from fieldDictionary Record
-}
fieldMessageTagger : Form.Field.Tagger Msg
fieldMessageTagger =
    Form.Field.tagger fieldDictionary


type Msg
    = FieldMsg Form.Field.Internal
    | Submit


update : Msg -> Model -> Model
update msg model =
    case msg of
        -- Run update routine for child module as usual.
        FieldMsg inMsg ->
            { model | field = Form.Field.update inMsg model.field }

        Submit ->
            { model | isSubmitted = True }


view : Model -> Html Msg
view model =
    if model.isSubmitted == False then
        Html.map fieldMessageTagger (Form.Field.view model.field)

    else
        text
            """
            Congratulations!
            You have succesxfully submitted the form,
            written in Elm using tagger.
            """
