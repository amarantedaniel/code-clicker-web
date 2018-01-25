module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


-- MODEL


type alias Model =
    { name : String
    , numberOfClicks : Int
    , clicksPerSecond : Int
    }


model : Model
model =
    { name = "Bla"
    , numberOfClicks = 0
    , clicksPerSecond = 0
    }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h2 [] [ text model.name ]
        , h2 [] [ text (formatNumberOfClicks model) ]
        , h2 [] [ text (formatClicksPerSecond model) ]
        , button [ class "cookie-button", onClick Click ] []
        ]



-- UPDATE


type Msg
    = Click


update : Msg -> Model -> Model
update msg model =
    case msg of
        Click ->
            { model | numberOfClicks = model.numberOfClicks + 1 }


formatNumberOfClicks : Model -> String
formatNumberOfClicks model =
    ((toString model.numberOfClicks) ++ " cookies")


formatClicksPerSecond : Model -> String
formatClicksPerSecond model =
    ("per Second: " ++ (toString model.clicksPerSecond))



-- PROGRAM


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = model
        , view = view
        , update = update
        }
