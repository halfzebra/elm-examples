module App exposing (..)

import Html exposing (Html, button, div, text)
import Html.Attributes exposing (src)
import Html.Events exposing (onClick)
import Http
import Json.Decode exposing (Decoder)


---- MODEL ----


type alias Model =
    { data : Maybe Data
    }


init : ( Model, Cmd Msg )
init =
    ( { data = Nothing }, Cmd.none )


type alias Data =
    { content : String }



---- UPDATE ----


decoder : Decoder Data
decoder =
    Json.Decode.map Data (Json.Decode.field "content" Json.Decode.string)


type Msg
    = Send
    | Response (Result Http.Error Data)


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



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ div [] [ text (toString model.data) ]
        , button [ onClick Send ] [ text "Get the data" ]
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
