module Game.Model exposing (..)


type alias Model =
    { name : String
    , numberOfClicks : Int
    , storeItems : List StoreItem
    }


type alias StoreItem =
    { name : String
    , currentPrice : Int
    , clicksPerSecond : Int
    , priceMultiplier : Float
    , numberBought : Int
    }


initialModel : Model
initialModel =
    { name = "Lixosoft Software"
    , numberOfClicks = 0
    , storeItems =
        []
    }
