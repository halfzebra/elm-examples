module Main exposing (..)

import Html exposing (beginnerProgram)
import Form exposing (view, update, init, Model, Msg)


main : Program Never Model Msg
main =
    beginnerProgram { view = view, update = update, model = init }
