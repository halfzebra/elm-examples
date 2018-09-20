module Main exposing (main)

import Browser
import Form exposing (Model, Msg, init, update, view)


main : Program () Model Msg
main =
    Browser.sandbox { view = view, update = update, init = init }
