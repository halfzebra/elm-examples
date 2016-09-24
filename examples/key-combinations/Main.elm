module Main exposing (..)

import Html exposing (text, Html)
import Html.App exposing (program)
import Keyboard exposing (KeyCode)


main : Program Never
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
    = Keydowns KeyCode
    | Keyups KeyCode


init : ( Model, Cmd Msg )
init =
    ( [], Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Keydowns code ->
            ( if List.member code model then
                model
              else
                model ++ [ code ]
            , Cmd.none
            )

        Keyups code ->
            ( List.filter (\v -> v /= code) model, Cmd.none )


view : Model -> Html Msg
view model =
    text (toString model)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Keyboard.downs Keydowns
        , Keyboard.ups Keyups
        ]
