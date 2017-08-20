module Main exposing (..)

import Html exposing (Html, button, div, text, input)
import Html.Events exposing (onClick, onInput)
import Http exposing (Error, Body)
import Json.Decode exposing (Decoder)
import Json.Encode


---- MODEL ----


type alias Data =
    { content : String }


type alias Model =
    { data : Maybe Data
    , inputValue : String
    }


init : ( Model, Cmd Msg )
init =
    ( { data = Nothing, inputValue = "" }, Cmd.none )



---- UPDATE ----


decoder : Decoder Data
decoder =
    Json.Decode.map Data (Json.Decode.field "content" Json.Decode.string)


encoder : String -> Body
encoder inputValue =
    [ ( "content", Json.Encode.string inputValue ) ]
        |> Json.Encode.object
        |> Http.jsonBody


type Msg
    = Send
    | Response (Result Error Data)
    | InputUpdate String
    | SendData
    | SendDataResponse (Result Error Data)


apiUrl : String
apiUrl =
    "http://localhost:3004/data"


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Send ->
            ( model
            , Http.send Response (Http.get apiUrl decoder)
            )

        Response res ->
            case res of
                Ok data ->
                    ( { model | data = Just data }, Cmd.none )

                Err err ->
                    ( model, Cmd.none )

        InputUpdate value ->
            ( { model | inputValue = value }, Cmd.none )

        SendData ->
            ( model
            , Http.send Response
                (Http.post
                    apiUrl
                    (encoder model.inputValue)
                    decoder
                )
            )

        SendDataResponse res ->
            case res of
                Ok data ->
                    ( { model | data = Just data }, Cmd.none )

                Err err ->
                    ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ div [] [ text (toString model.data) ]
        , input [ onInput InputUpdate ] []
        , button [ onClick Send ] [ text "Get the data" ]
        , button [ onClick SendData ] [ text "Send data to server" ]
        ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        }
