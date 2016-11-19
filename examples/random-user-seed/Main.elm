module Main exposing (..)

import Html exposing (beginnerProgram, text, div, button, input, Html)
import Html.Attributes exposing (value, placeholder)
import Html.Events exposing (onInput, onClick)
import Random exposing (Seed, Generator)
import String


generator : Int -> Generator (List Int)
generator length =
    Random.list length (Random.int 0 100)


view : Model -> Html Msg
view model =
    div
        []
        (input [ value model.input, placeholder "Enter numeric seed", onInput Update ] []
            :: case model.state of
                Ok state ->
                    [ button [ onClick Next ] [ text "Next" ], text (toString (Tuple.first state)) ]

                Err msg ->
                    [ text msg ]
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
            let
                seed =
                    Result.map Random.initialSeed (String.toInt model.input)

                newState =
                    Result.map (Random.step (generator 10)) seed
            in
                { model | state = newState }

        Next ->
            { model | state = Result.map (Random.step (generator 10) << Tuple.second) model.state }


type alias Model =
    { state : Result String ( List Int, Seed )
    , input : String
    }


init : Model
init =
    Model (Err "Seed is not available") ""


main : Program Never Model Msg
main =
    beginnerProgram
        { view = view
        , model = init
        , update = update
        }
