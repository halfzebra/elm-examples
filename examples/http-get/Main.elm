module Main exposing (Model, Msg(..), Repo, decoder, getRepos, init, main, repoDecoder, sendGet, subscriptions, update, url, view)

import Browser
import Debug
import Html exposing (Html, button, div, input, p, text)
import Html.Attributes exposing (value)
import Html.Events exposing (onClick, onInput)
import Http exposing (Error(..), Response, get)
import Json.Decode exposing (Decoder, field, int, string)
import Task
import Url.Builder as Url


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \() -> init
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
    , error : Maybe Error
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
    Url.crossOrigin "https://api.github.com" [ "users", query, "repos" ] []


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

        LoadRepos maybeRepos ->
            case maybeRepos of
                Ok repos ->
                    ( { model | repos = repos }, Cmd.none )

                Err err ->
                    ( { model | repos = [], error = Just err }, Cmd.none )


sendGet : (Result Error a -> msg) -> String -> Decoder a -> Cmd msg
sendGet msg theUrl theDecoder =
    Http.get theUrl theDecoder
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
        , text
            (case model.error of
                Nothing ->
                    ""

                Just error ->
                    "Error: " ++ Debug.toString error
            )
        ]
