module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


-- MODEL


type alias Model =
    { name : String
    , numberOfClicks : Int
    , clicksPerSecond : Int
    , storeItems : List StoreItem
    }


type alias StoreItem =
    { name : String
    , price : Int
    , clicksPerSecond : Int
    }


model : Model
model =
    { name = "Lixosoft Software"
    , numberOfClicks = 0
    , clicksPerSecond = 0
    , storeItems = []
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
storeItemView model =
    li [] [ text "blableee" ]



-- UPDATE


type Msg
    = Click


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Click ->
            { model | numberOfClicks = model.numberOfClicks + 1 } ! []


formatNumberOfClicks : Model -> String
formatNumberOfClicks model =
    ((toString model.numberOfClicks) ++ " lines of code")


formatClicksPerSecond : Model -> String
formatClicksPerSecond model =
    ("per second: " ++ (toString model.clicksPerSecond))



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- PROGRAM


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
