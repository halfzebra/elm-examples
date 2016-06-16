port module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as Html
import String
import Task
import Platform.Cmd exposing (Cmd)
import Debug


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- SUBSCRIPTIONS


port output : () -> Cmd msg


port input : (Int -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model =
    input Get



-- MODEL


type alias Model =
    { number : Int }



-- VIEW


view : Model -> Html Msg
view model =
    Html.text (toString model.number)



-- UPDATE


type Msg
    = Ask
    | Get Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case (Debug.log "MESSAGE: " msg) of
        Ask ->
            ( model, output () )

        Get x ->
            ( Model x, Cmd.none )



-- INIT


init : ( Model, Cmd Msg )
init =
    ( Model 0, send Ask )


send : msg -> Cmd msg
send msg =
    Task.perform identity identity (Task.succeed msg)
