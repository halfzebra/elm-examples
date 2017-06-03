module App exposing (..)

import Html exposing (Html, button, div, text, input)
import Html.Events exposing (onClick, onInput)
import Http
import Json.Decode exposing (Decoder)
import Json.Encode


---- MODEL ----


type alias Model =
    { data : Maybe Data
    , inputValue : String
    }


init : ( Model, Cmd Msg )
init =
    ( { data = Nothing, inputValue = "" }, Cmd.none )


type alias Data =
    { content : String }



---- UPDATE ----


decoder : Decoder Data
decoder =
    Json.Decode.map Data (Json.Decode.field "content" Json.Decode.string)

encoder inputValue = 
    Http.jsonBody (Json.Encode.object [ ( "content", Json.Encode.string inputValue ) ])

        
type Msg
    = Send
    | Response (Result Http.Error Data)
    | InputUpdate String
    | SendData
    | SendDataResponse (Result Http.Error Data) -- actually not the data


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Send ->
            ( model, Http.send Response (Http.get "http://localhost:3004/data" decoder) )

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
            , Http.send Response (Http.post "http://localhost:3004/data" ( encoder model.inputValue ) decoder) )

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
        , button [ onClick Send ] [ text "Get the data" ]
        , input [ onInput InputUpdate ] []
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
