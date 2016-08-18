module Main exposing (..)

import Html.App exposing (beginnerProgram)
import Components.Form exposing (view, update, init)


main : Program Never
main =
    beginnerProgram { view = view, update = update, model = init }
