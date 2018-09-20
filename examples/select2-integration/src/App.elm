port module App exposing (Model, Msg(..), init, input, options, output, subscriptions, update, view)

import Dict exposing (Dict)
import Html exposing (Html, div, text)
import Html.Attributes exposing (id)


type alias Model =
    { selection : Maybe String }


modelToString : Model -> String
modelToString model =
    case model.selection of
        Nothing ->
            "Nothing"

        Just s ->
            "Just " ++ s


init : ( Model, Cmd Msg )
init =
    ( Model Nothing, output (Dict.toList options) )


type Msg
    = Select String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Select val ->
            let
                option : Maybe String
                option =
                    Dict.get val options
            in
            ( { model | selection = option }, Cmd.none )


view : Model -> Html Msg
view model =
    div
        []
        [ text (modelToString model)
        , div [ id "select2-container" ] []
        ]


port output : List ( String, String ) -> Cmd msg


port input : (String -> msg) -> Sub msg


options : Dict String String
options =
    Dict.fromList
        [ ( "US", "United States" )
        , ( "UK", "United Kingdom" )
        , ( "UY", "Uruguay" )
        , ( "UZ", "Uzbekistan" )
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    input Select
