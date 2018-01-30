module Main exposing (..)

import Model exposing (..)
import Update exposing (..)
import View exposing (view)
import Html exposing (program)
import Time exposing (..)


init : ( Model, Cmd Msg )
init =
    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    every second Tick


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
