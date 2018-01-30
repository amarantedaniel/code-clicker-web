module View exposing (..)

import Model exposing (..)
import Update exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


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
            , ul [ class "unbulleted-list" ] (List.map storeItemView model.storeItems)
            ]
        ]


storeItemView : StoreItem -> Html Msg
storeItemView storeItem =
    li [ onClick (Buy storeItem) ]
        [ div [ class "store-item" ]
            [ div [] [ text storeItem.name ]
            , div [] [ text ("price: " ++ (toString storeItem.basePrice)) ]
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
