module Main exposing (Model, Msg(..), init, main, subscriptions, update, view)

import Browser
import Browser.Events as Events
import Debug
import Html exposing (Html, text)
import Json.Decode as Decode


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \() -> init
        , subscriptions = subscriptions
        , update = update
        }



-- See https://github.com/elm/browser/blob/1.0.0/notes/keyboard.md


type alias Model =
    List String


type Msg
    = KeyDowns String
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
    text (Debug.toString model)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Events.onKeyDown (Decode.map KeyDowns keyDecoder)
        , Events.onKeyUp (Decode.succeed ClearPressed)
        ]


keyDecoder : Decode.Decoder String
keyDecoder =
    Decode.field "key" Decode.string
