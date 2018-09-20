module App.Counter.Model exposing (Model, init)


type alias Model =
    Int


init : Int -> Model
init start =
    start
