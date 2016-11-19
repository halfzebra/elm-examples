port module Main exposing (..)

import String
import Task
import Html exposing (..)
import Html.Attributes exposing (..)


main : Program Never Model Msg
main =
    program
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
    text (toString model.number)



-- UPDATE


type Msg
    = Get Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case (Debug.log "MESSAGE: " msg) of
        Get x ->
            ( Model x, Cmd.none )



-- INIT


init : ( Model, Cmd Msg )
init =
    {- Send a message through port upon initialization. -}
    ( Model 0, output () )
