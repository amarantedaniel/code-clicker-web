module Main exposing (..)

import Model exposing (..)
import Update exposing (..)
import StoreFacade exposing (fetchItems)
import View exposing (view)
import Html exposing (program)
import Time exposing (..)


init : ( Model, Cmd Msg )
init =
    ( model, StoreFacade.fetchItems FetchItemsResponse )


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
