module Main exposing (..)

import Html exposing (div, input, text, label)
import Html.App exposing (beginnerProgram)
import Html.Events exposing (onCheck)
import Html.Attributes exposing (type', checked)
import Dict


(=>) : a -> b -> ( a, b )
(=>) a b =
    ( a, b )


main =
    beginnerProgram { model = model, view = view, update = update }


model =
    { name = ""
    , disruptedFields =
        Dict.fromList
            [ "advertising"
                => { name = "Advertising"
                   , checked = False
                   }
            , "travel"
                => { name = "Travel"
                   , checked = False
                   }
            , "utilities"
                => { name = "Utilities"
                   , checked = False
                   }
            ]
    }


type Msg
    = Check String Bool


view model =
    let
        checkbox ( key, data ) =
            label []
                [ text data.name
                , input
                    [ type' "checkbox"
                    , checked data.checked
                    , onCheck (Check key)
                    ]
                    []
                ]
    in
        div []
            (model.disruptedFields
                |> Dict.toList
                |> List.map checkbox
            )


update msg model =
    case msg of
        Check checkboxId checked ->
            let
                updateRecord =
                    Maybe.map (\checkboxData -> { checkboxData | checked = checked })

                disruptedFieldsUpdated =
                    Dict.update checkboxId
                        updateRecord
                        model.disruptedFields
            in
                { model | disruptedFields = disruptedFieldsUpdated }
