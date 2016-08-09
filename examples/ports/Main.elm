port module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as Html
import String
import Task
import Platform.Cmd exposing (Cmd)
import Debug


main : Program Never
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- SUBSCRIPTIONS


{-| Outgoing port sends an empty Tuple in this example.

   Empty Tuples are called Holes.
-}
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
    ( Model 0, sendMsg Ask )


{-| This function is running a Task, which always succeedes and always results
    in to sendng a msg to update function.

    In other words, this is a Cmd, which sends passed message.

    Use cases:
        - Emitting an action on init.
        - Triggering an action in a child, to allow parent to intercept it.
-}
sendMsg : msg -> Cmd msg
sendMsg msg =
    Task.perform identity identity (Task.succeed msg)
