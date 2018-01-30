module Update exposing (..)

import Model exposing (..)
import Time exposing (..)


type Msg
    = Click
    | Buy StoreItem
    | Tick Time


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Click ->
            { model | numberOfClicks = model.numberOfClicks + 1 } ! []

        Buy storeItem ->
            if model.numberOfClicks >= storeItem.basePrice then
                { model
                    | storeItems =
                        List.map
                            (\item ->
                                if item.name == storeItem.name then
                                    { item | numberBought = storeItem.numberBought + 1 }
                                else
                                    item
                            )
                            model.storeItems
                    , numberOfClicks = model.numberOfClicks - storeItem.basePrice
                }
                    ! []
            else
                model
                    ! []

        Tick time ->
            { model | numberOfClicks = model.numberOfClicks + (calculateClicksPerSecond model) } ! []


calculateClicksPerSecond : Model -> Int
calculateClicksPerSecond model =
    List.map (\storeItem -> storeItem.clicksPerSecond * storeItem.numberBought) model.storeItems
        |> List.sum
