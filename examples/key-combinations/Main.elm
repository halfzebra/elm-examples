module Main exposing (..)

import Html exposing (program, text, Html)
import Keyboard exposing (KeyCode)


main : Program Never Model Msg
main =
    program
        { view = view
        , init = init
        , subscriptions = subscriptions
        , update = update
        }


type alias Model =
    List KeyCode


type Msg
    = KeyDowns KeyCode
    | ClearPressed


init : ( Model, Cmd Msg )
init =
    ( [], Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        KeyDowns code ->
            ( if List.member code model then
                model
              else
                code :: model
            , Cmd.none
            )

        -- Flush the whole model on `keyup`, helps to remove not pressed keys, if focus was lost from the window.
        ClearPressed ->
            ( [], Cmd.none )


view : Model -> Html Msg
view model =
    text (toString model)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Keyboard.downs KeyDowns
        , Keyboard.ups (always ClearPressed)
        ]
