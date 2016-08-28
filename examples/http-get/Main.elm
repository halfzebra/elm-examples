module Main exposing (..)

import Json.Decode exposing ((:=), int, string, Decoder)
import Html exposing (text, div, input, button, p, Html)
import Html.Attributes exposing (value)
import Html.Events exposing (onClick, onInput)
import Html.App exposing (program)
import Http exposing (get, Error)
import Task

main : Program Never
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
    }


init : ( Model, Cmd Msg )
init =
    ( Model "evancz" [], Cmd.none )


decoder : Decoder (List Repo)
decoder =
    Json.Decode.list repoDecoder


repoDecoder : Decoder Repo
repoDecoder =
    Json.Decode.object2 Repo
        ("id" := int)
        ("full_name" := string)


url : String -> String
url query =
    "https://api.github.com/users/" ++ query ++ "/repos"


getRepos : String -> Cmd Msg
getRepos query =
    sendGet ResponseFail ResponseSuccess (url query) decoder


type Msg
    = UpdateQuery String
    | Search
    | ResponseSuccess (List Repo)
    | ResponseFail Error


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateQuery value ->
            ( { model | query = value }, Cmd.none )

        Search ->
            ( model, getRepos model.query )

        ResponseSuccess repos ->
            ( { model | repos = repos }, Cmd.none )

        ResponseFail err ->
            case err of
                Http.UnexpectedPayload errorMessage ->
                    Debug.log errorMessage
                    ( model, Cmd.none )
                _ ->
                    ( model, Cmd.none )


sendGet : (Error -> a) -> (b -> a) -> String -> Decoder b -> Cmd a
sendGet fail success url decoder =
    Http.get decoder url
        |> Task.perform fail success


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
