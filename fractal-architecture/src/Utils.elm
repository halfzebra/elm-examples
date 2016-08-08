module Utils exposing (..)


log : Bool -> String -> a -> a
log dev label val =
    if dev == True then
        Debug.log label val
    else
        val
