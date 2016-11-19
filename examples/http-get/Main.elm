module Main exposing (..)

import Json.Decode exposing (field, int, string, Decoder)
import Html exposing (text, div, input, button, p, Html)
import Html.Attributes exposing (value)
import Html.Events exposing (onClick, onInput)
import Html exposing (program)
import Http exposing (get, Error, Response, Error(..))
import Task


main : Program Never Model Msg
main =
    program
        { view = view
        , init = init
        , update = update
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


type alias Repo =
    { id : Int
    , full_name : String
    }


type alias Model =
    { query : String
    , repos : List Repo
    , error : Maybe String
    }


init : ( Model, Cmd Msg )
init =
    ( Model "evancz" [] Nothing, Cmd.none )


decoder : Decoder (List Repo)
decoder =
    Json.Decode.list repoDecoder


repoDecoder : Decoder Repo
repoDecoder =
    Json.Decode.map2 Repo
        (field "id" int)
        (field "full_name" string)


url : String -> String
url query =
    "https://api.github.com/users/" ++ query ++ "/repos"


getRepos : String -> Cmd Msg
getRepos query =
    sendGet LoadRepos (url query) decoder


type Msg
    = UpdateQuery String
    | Search
    | LoadRepos (Result Http.Error (List Repo))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateQuery value ->
            ( { model | query = value }, Cmd.none )

        Search ->
            ( model, getRepos model.query )

        LoadRepos repos ->
            case repos of
                Ok repos ->
                    ( { model | repos = repos }, Cmd.none )

                Err err ->
                    Debug.crash "" err


sendGet : (Result Error a -> msg) -> String -> Decoder a -> Cmd msg
sendGet msg url decoder =
    Http.get url decoder
        |> Http.send msg


view : Model -> Html Msg
view model =
    div []
        [ input
            [ onInput UpdateQuery, value model.query ]
            []
        , button [ onClick Search ] [ text "Search" ]
        , div
            []
            (List.map (\{ full_name } -> p [] [ text full_name ]) model.repos)
        ]
