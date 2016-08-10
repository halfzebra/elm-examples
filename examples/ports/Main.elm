port module Main exposing (..)

import String
import Debug
import Cmd.Extra exposing (message)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as Html


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
    {- Port communication is initialized after init is called, making it impossible to send an outgoing port message
       upon the initialization.

       The workaround is to send a message, using Cmd.Extra.message

       This will change with future versions of Elm.
    -}
    ( Model 0, message Ask )
