module Main exposing (..)

import Html exposing (program, text, div, Html)
import Input
import Helper


main : Program Never Model Msg
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


type alias Model =
    { name : Input.Model
    , helper : Helper.Model
    }


init : ( Model, Cmd Msg )
init =
    let
        -- Omit the Cmd from child's init, because we know that it's Cmd.none
        ( nameModel, _ ) =
            Input.init "John"

        ( helperModel, _ ) =
            Helper.init "Please enter your name"
    in
        ( Model nameModel helperModel, Cmd.none )


type Msg
    = NameMsg Input.Msg
    | HelperMsg Helper.Msg


view : Model -> Html Msg
view model =
    div []
        [ text (model.name)
        , Html.map NameMsg (Input.view model.name)
        , Html.map HelperMsg (Helper.view model.helper)
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NameMsg childMsg ->
            case childMsg of
                {- We have intercepted a message from child module.

                   This part of the update function might be moved
                   to a separate function for better readability.
                -}
                Input.Focus ->
                    update (HelperMsg Helper.Show) model

                Input.Blur ->
                    update (HelperMsg Helper.Hide) model

                -- The default message passing routine.
                _ ->
                    let
                        ( nameModel, nameCmd ) =
                            Input.update childMsg model.name
                    in
                        ( { model | name = nameModel }
                        , Cmd.map NameMsg nameCmd
                        )

        HelperMsg childMsg ->
            let
                ( helperModel, helperCmd ) =
                    Helper.update childMsg model.helper
            in
                ( { model | helper = helperModel }
                , Cmd.map HelperMsg helperCmd
                )
