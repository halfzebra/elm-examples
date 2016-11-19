module Input exposing (..)

{- This is an input module, which emits messages, when user types anything,
   focuses on it, or when focus leaves the field.
-}

import Html exposing (input, Html)
import Html.Attributes exposing (type_, value)
import Html.Events exposing (onInput, onFocus, onBlur)


type alias Model =
    String


init : Model -> ( Model, Cmd Msg )
init text =
    ( text, Cmd.none )


type Msg
    = Update Model
    | Focus
    | Blur


view : Model -> Html Msg
view model =
    input
        [ type_ "text"
        , onInput Update
        , onFocus Focus
        , onBlur Blur
        , value model
        ]
        []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Update value ->
            ( value, Cmd.none )

        -- Ignore the rest of the messages.
        _ ->
            ( model, Cmd.none )
