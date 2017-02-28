module Main exposing (..)

import Html exposing (program, div, button, text)
import Html.Events exposing (onClick)
import Random exposing (Generator, Seed)


main =
    program
        { init =
            ( { seed = Nothing, stack = [] }
              -- Initial command to create independent Seed.
            , Random.generate Update seedGenerator
            )
        , view = view
        , update = update
        , subscriptions = \model -> Sub.none
        }


view model =
    div []
        [ button
            [ onClick PutRandomNumber ]
            [ text "Generate random BMI data" ]
        , div
            []
            (List.map (text << toString) model.stack)
        ]


type alias Model =
    { seed : Maybe Seed
    , stack : List BMI
    }


type alias BMI =
    { weight : Float
    , height : Float
    , bmi : Float
    }


valueGenerator : Generator BMI
valueGenerator =
    Random.map2
        (\w h -> BMI w h (w / (h * h)))
        (Random.float 60 150)
        (Random.float 0.6 1.2)


type Msg
    = Update Seed
    | PutRandomNumber


seedGenerator : Generator Seed
seedGenerator =
    Random.int Random.minInt Random.maxInt
        |> Random.map (Random.initialSeed)


valueGenerator : Generator BMI
valueGenerator =
    Random.map2
        (\w h -> BMI w h (w / (h * h)))
        (Random.float 60 150)
        (Random.float 0.6 1.2)


update msg model =
    case msg of
        Update seed ->
            -- Preserve newly initialized Seed state.
            ( { model | seed = Just seed }, Cmd.none )

        PutRandomNumber ->
            let
                {- In case if seed was present, new model will contain the new value
                   and a new state for the seed.
                -}
                newModel : Model
                newModel =
                    model.seed
                        |> Maybe.map (Random.step valueGenerator)
                        |> Maybe.map
                            (\( number, seed ) ->
                                { model
                                    | seed = Just seed
                                    , stack = number :: model.stack
                                }
                            )
                        |> Maybe.withDefault model
            in
                ( newModel
                , Cmd.none
                )
