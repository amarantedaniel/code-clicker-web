module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Time exposing (..)


-- MODEL


type alias Model =
    { name : String
    , numberOfClicks : Int
    , storeItems : List StoreItem
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



-- STORE ITEMS


type alias StoreItem =
    { name : String
    , price : Int
    , clicksPerSecond : Int
    , numberBought : Int
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


init : ( Model, Cmd Msg )
init =
    ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "main-container" ]
        [ div [ class "small-container" ]
            [ h2 [] [ text model.name ]
            , h2 [] [ text (formatNumberOfClicks model) ]
            , h2 [] [ text (formatClicksPerSecond model) ]
            , button [ class "cookie-button", onClick Click ] []
            ]
        , div [ class "small-container" ]
            [ h2 [] [ text "Store" ]
            , ul [] (List.map storeItemView model.storeItems)
            ]
        ]


storeItemView : StoreItem -> Html Msg
storeItemView storeItem =
    li [ onClick (Buy storeItem) ]
        [ div [ class "store-item" ]
            [ text storeItem.name
            , text (toString storeItem.price)
            , text (toString storeItem.clicksPerSecond)
            , text (toString storeItem.numberBought)
            ]
        ]



-- UPDATE


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
            let
                buyItem thisItem =
                    if thisItem.name == storeItem.name then
                        { thisItem | numberBought = storeItem.numberBought + 1 }
                    else
                        thisItem
            in
                { model | storeItems = List.map buyItem model.storeItems } ! []

        Tick time ->
            { model | numberOfClicks = model.numberOfClicks + (calculateClicksPerSecond model) } ! []


formatNumberOfClicks : Model -> String
formatNumberOfClicks model =
    ((toString model.numberOfClicks) ++ " lines of code")


formatClicksPerSecond : Model -> String
formatClicksPerSecond model =
    ("per second: " ++ (toString (calculateClicksPerSecond model)))


calculateClicksPerSecond : Model -> Int
calculateClicksPerSecond model =
    List.map (\storeItem -> storeItem.clicksPerSecond * storeItem.numberBought) model.storeItems
        |> List.sum


subscriptions : Model -> Sub Msg
subscriptions model =
    every second Tick



-- PROGRAM


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
