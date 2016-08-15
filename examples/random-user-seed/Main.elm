module Main exposing (..)

import Html exposing (text, div, button, input, Html)
import Html.Attributes exposing (value, placeholder)
import Html.Events exposing (onInput, onClick)
import Html.App exposing (beginnerProgram)
import Random exposing (Seed, Generator)
import String
import Debug

generator : Int -> Generator (List Int)
generator length =
    Random.list length (Random.int 0 100)


view : Model -> Html Msg
view model =
    div
        []
        (input [ value model.input, placeholder "Enter the seed", onInput Update ] []
         ::
         case model.state of
            Ok state ->
                [ button [ onClick Next ] [ text "Next" ], text (toString (fst state)) ]

            Err msg ->
                [ text msg ]
        )

type Msg
    = Update String
    | Next


update : Msg -> Model -> Model
update msg model =
    case msg of
        Update val ->
            let
                seed =
                    Result.map Random.initialSeed (String.toInt val)

                newState =
                    Result.map (Random.step (generator 10)) seed
            in
                { model | input = val, state = newState }

        Next ->
            { model | state = Result.map (Random.step (generator 10) << snd) model.state }



type alias Model =
    { state : Result String ( List Int, Seed )
    , input : String
    }


init : Model
init =
    Model (Err "Seed is not available") ""


main : Program Never
main =
    beginnerProgram
        { view = view
        , model = init
        , update = update
        }