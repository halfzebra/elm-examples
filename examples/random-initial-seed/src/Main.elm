module Main exposing (Model, Msg(..), main, seedGenerator, update, view)

import Browser
import Debug
import Html exposing (button, div, text)
import Html.Events exposing (onClick)
import Random exposing (Generator, Seed)



-- TODO


main =
    Browser.element
        { init =
            \() ->
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
            [ text "Put a random value on a stack" ]
        , text (Debug.toString model.stack)
        ]


type alias Model =
    { seed : Maybe Seed
    , stack : List Int
    }


type Msg
    = Update Seed
    | PutRandomNumber


seedGenerator : Generator Seed
seedGenerator =
    Random.int Random.minInt Random.maxInt
        |> Random.map Random.initialSeed


update msg model =
    case msg of
        Update seed ->
            -- Preserve newly initialized Seed state.
            ( { model | seed = Just seed }, Cmd.none )

        PutRandomNumber ->
            let
                -- In case if seed was present, new model will contain the new value and a new state for the seed.
                newModel : Model
                newModel =
                    model.seed
                        |> Maybe.map (Random.step (Random.int 0 10))
                        |> Maybe.map
                            (\( number, seed ) ->
                                { model | seed = Just seed, stack = number :: model.stack }
                            )
                        |> Maybe.withDefault model
            in
            ( newModel
            , Cmd.none
            )
