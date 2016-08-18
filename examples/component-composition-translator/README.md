# Component composition in Elm with Translator pattern in Elm

Example app, featuring the [Translator](https://medium.com/@alex.lew/the-translator-pattern-a-model-for-child-to-parent-communication-in-elm-f4bfaa1d3f98) for component-composition.

## Motivation
The key takeaway of this example is that you can use the second argument of [Html.App.map](http://package.elm-lang.org/packages/elm-lang/html/1.1.0/Html-App#map) to have more control over the message flow in your top-level `update` function.

The idea, introduced in the article, improves on `tagger` formula and might be used as an inspiration for generic APIs.

Please consider this example:
```elm
import Child


type Msg
    = SomeMsg
    | ToChild Child.Msg


-- Tagger function, for better control over the message flow.


tagger : Child.Msg -> Msg 
tagger msg =
    case msg of
        Child.SomeMsg ->
            SomeMsg
            
        _ ->
            ToChild msg


-- Top-level view


view : Model -> Html Msg
view model =
    Cmd.map tagger (Child.view model.childState)
    
```

## Building the example

```sh
$ elm-package istall -y
$ elm-make Main.elm
```