module Game.Update exposing (..)

import Http exposing (Error)
import Game.Model exposing (..)
import Time exposing (..)
import Facade.Store exposing (fetchItems)


type Msg
    = Click
    | FetchItemsResponse (Result Http.Error (List StoreItem))
    | Buy StoreItem
    | Tick Time


update : String -> Msg -> Model -> ( Model, Cmd Msg )
update token msg model =
    case msg of
        Click ->
            { model | numberOfClicks = model.numberOfClicks + 1 } ! []

        FetchItemsResponse (Ok items) ->
            { model | storeItems = items } ! []

        FetchItemsResponse (Err error) ->
            model ! []

        Buy storeItem ->
            if model.numberOfClicks >= storeItem.currentPrice then
                { model
                    | storeItems =
                        List.map
                            (\item ->
                                if item.name == storeItem.name then
                                    { item
                                        | numberBought = storeItem.numberBought + 1
                                        , currentPrice = round ((toFloat storeItem.currentPrice) * storeItem.priceMultiplier)
                                    }
                                else
                                    item
                            )
                            model.storeItems
                    , numberOfClicks = model.numberOfClicks - storeItem.currentPrice
                }
                    ! []
            else
                model ! []

        Tick time ->
            { model | numberOfClicks = model.numberOfClicks + (calculateClicksPerSecond model) } ! []


calculateClicksPerSecond : Model -> Int
calculateClicksPerSecond model =
    List.map (\storeItem -> storeItem.clicksPerSecond * storeItem.numberBought) model.storeItems
        |> List.sum


init : ( Model, Cmd Msg )
init =
    ( initialModel, Facade.Store.fetchItems FetchItemsResponse )


subscriptions : Model -> Sub Msg
subscriptions model =
    every second Tick
