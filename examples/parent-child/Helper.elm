module Helper exposing (..)

{- This component simply shows and hides text -}

import Html exposing (text, div, Html)


type alias Model =
    { text : String
    , visible : Bool
    }


init : String -> ( Model, Cmd Msg )
init text =
    {- Returning Cmd Msg from child component is not necessary,
       and the signature of init and update function might be simplified to:

       String -> Model
       Msg -> Model -> Model

       Here I return Cmd.none just to follow Fractal Architecture pattern.
    -}
    ( Model text False, Cmd.none )


type Msg
    = Show
    | Hide


view : Model -> Html Msg
view model =
    if model.visible == True then
        div [] [ text model.text ]
    else
        text ""


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Show ->
            ( { model | visible = True }, Cmd.none )

        Hide ->
            ( { model | visible = False }, Cmd.none )
