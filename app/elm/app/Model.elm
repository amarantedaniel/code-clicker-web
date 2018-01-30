module Model exposing (..)


type alias Model =
    { name : String
    , numberOfClicks : Int
    , storeItems : List StoreItem
    }


type alias StoreItem =
    { name : String
    , basePrice : Int
    , clicksPerSecond : Int
    , priceMultiplier : Float
    , numberBought : Int
    }


model : Model
model =
    { name = "Lixosoft Software"
    , numberOfClicks = 0
    , storeItems =
        []
    }
