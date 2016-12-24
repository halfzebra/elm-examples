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


{-| With an outgoing port, I want to tell JavaScript to send some value to Elm.
    That does not require sending data to JavaScript, so I send an empty Tuple.

    Note, that you can not specify the exact message type of port commands.

    Both port functions can be exported and used outside of the module.
    Since output does not emit any messages, we have type annotation definition with a generic `msg`,
    so it's easier to use it outside of this module
    and you don't have to use Cmd.map to re-map a non-existing message type.

    The subscription as well can be used outside of this module,
    you can use any message type to receive messages from the port.
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
