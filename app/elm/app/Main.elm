module Main exposing (..)

-- import StoreFacade exposing (fetchItems)
-- import Time exposing (..)

import Game
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)


-- MODEL --


type Page
    = GamePage
    | LoginPage


type alias Model =
    { page : Page
    , game : Game.Model
    , login : String
    }


initialModel : Model
initialModel =
    { page = GamePage
    , game = Game.initialModel
    , login = ""
    }



-- UPDATE --


type Msg
    = ChangePage Page
    | GameMsg Game.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangePage page ->
            { model | page = page } ! []

        GameMsg gameMsg ->
            { model | game = Game.update gameMsg model.game } ! []



-- VIEW --


view : Model -> Html Msg
view model =
    let
        page =
            case model.page of
                GamePage ->
                    Html.map GameMsg (Game.view model.game)

                LoginPage ->
                    Html.text "Login"
    in
        div []
            [ div []
                [ a
                    [ href "#"
                    , onClick (ChangePage LoginPage)
                    ]
                    [ text "Login" ]
                , span [] [ text " | " ]
                , a
                    [ href "#"
                    , onClick (ChangePage GamePage)
                    ]
                    [ text "Game" ]
                ]
            , hr [] []
            , page
            ]



-- TODO: add initial command


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )



-- TODO: add back ticks
-- every second Tick


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
