module Main exposing (Model, Msg(..), generator, init, main, update, view)

import Browser
import Debug
import Html exposing (Html, button, div, input, text)
import Html.Attributes exposing (placeholder, value)
import Html.Events exposing (onClick, onInput)
import Random exposing (Generator, Seed)
import String


generator : Int -> Generator (List Int)
generator length =
    Random.list length (Random.int 0 100)


view : Model -> Html Msg
view model =
    div
        []
        (input [ value model.input, placeholder "Enter numeric seed", onInput Update ] []
            :: (case model.state of
                    Ok state ->
                        [ button [ onClick Next ] [ text "Next" ], text (Debug.toString (Tuple.first state)) ]

                    Err msg ->
                        [ text msg ]
               )
        )


type Msg
    = Update String
    | CreateSeed
    | Next


update : Msg -> Model -> Model
update msg model =
    case msg of
        Update val ->
            update CreateSeed { model | input = val }

        CreateSeed ->
            case String.toInt model.input of
                Nothing ->
                    { model | state = Err (model.input ++ " is not a valid Int") }

                Just theInt ->
                    let
                        seed =
                            Random.initialSeed theInt

                        newState =
                            Random.step (generator 10) seed
                    in
                    { model | state = Ok newState }

        Next ->
            { model | state = Result.map (Random.step (generator 10) << Tuple.second) model.state }


type alias Model =
    { state : Result String ( List Int, Seed )
    , input : String
    }


init : Model
init =
    Model (Err "Seed is not available") ""


main : Program () Model Msg
main =
    Browser.sandbox
        { view = view
        , init = init
        , update = update
        }
