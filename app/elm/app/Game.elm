module Game exposing (..)

import Http exposing (Error)
import Time exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


-- MODEL --


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



-- UPDATE --


type Msg
    = Click
    | FetchItemsResponse (Result Http.Error (List StoreItem))
    | Buy StoreItem
    | Tick Time


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
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



-- VIEW --


view : Model -> Html Msg
view model =
    div [ class "main-container" ]
        [ div [ class "small-container" ]
            [ h2 [] [ text model.name ]
            , h2 [] [ text (formatNumberOfClicks model) ]
            , h2 [] [ text (formatClicksPerSecond model) ]
            , button [ class "cookie-button", onClick Click ] []
            ]
        , div []
            [ img [ src "https://i.imgur.com/iVHfwLc.gif" ] []
            ]
        , div [ class "small-container" ]
            [ h2 [] [ text "Store" ]
            , ul [ class "unbulleted-list" ] (List.map storeItemView model.storeItems)
            ]
        ]


storeItemView : StoreItem -> Html Msg
storeItemView storeItem =
    li [ onClick (Buy storeItem) ]
        [ div [ class "store-item" ]
            [ div [] [ text storeItem.name ]
            , div [] [ text ("price: " ++ (toString storeItem.currentPrice)) ]
            , div [] [ text ("lines per second: " ++ (toString storeItem.clicksPerSecond)) ]
            , div [] [ text ("acquired: " ++ (toString storeItem.numberBought)) ]
            ]
        ]


formatNumberOfClicks : Model -> String
formatNumberOfClicks model =
    ((toString model.numberOfClicks) ++ " lines of code")


formatClicksPerSecond : Model -> String
formatClicksPerSecond model =
    ("per second: " ++ (toString (calculateClicksPerSecond model)))
