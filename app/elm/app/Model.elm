module Model exposing (..)


type alias Model =
    { name : String
    , numberOfClicks : Int
    , storeItems : List StoreItem
    }


type alias StoreItem =
    { name : String
    , price : Int
    , clicksPerSecond : Int
    , numberBought : Int
    }


model : Model
model =
    { name = "Lixosoft Software"
    , numberOfClicks = 0
    , storeItems =
        [ codeMonkeyStoreItem
        , softwareDevStoreItem
        ]
    }


codeMonkeyStoreItem : StoreItem
codeMonkeyStoreItem =
    { name = "Code Monkey"
    , price = 10
    , clicksPerSecond = 10
    , numberBought = 0
    }


softwareDevStoreItem : StoreItem
softwareDevStoreItem =
    { name = "Proper Software Developer"
    , price = 50
    , clicksPerSecond = 50
    , numberBought = 0
    }
