module Main exposing (..)

-- import Time exposing (..)

import Game.Model
import Game.Update
import Game.View
import Html exposing (..)
import Html.Attributes exposing (..)
import Navigation


-- MODEL --


type Page
    = GamePage
    | LoginPage


type alias Model =
    { page : Page
    , game : Game.Model.Model
    , login : String
    }



-- UPDATE --


type Msg
    = ChangePage Page
    | GameMsg Game.Update.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangePage page ->
            { model | page = page } ! []

        GameMsg gameMsg ->
            let
                ( gameModel, gameCmd ) =
                    Game.Update.update gameMsg model.game
            in
                ( { model | game = gameModel }, Cmd.map GameMsg gameCmd )



-- VIEW --


view : Model -> Html Msg
view model =
    let
        page =
            case model.page of
                GamePage ->
                    Html.map GameMsg (Game.View.view model.game)

                LoginPage ->
                    Html.text "Login"
    in
        div []
            [ div [ class "links-menu" ]
                [ a
                    [ href "#" ]
                    [ text "Code Clicker" ]
                , div
                    []
                    [ a
                        [ href "#/login" ]
                        [ text "Sign Up" ]
                    , span [] [ text " | " ]
                    , a
                        [ href "#/login" ]
                        [ text "Login" ]
                    ]
                ]
            , hr [] []
            , page
            ]


main : Program Never Model Msg
main =
    Navigation.program locationToMsg
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


locationToMsg : Navigation.Location -> Msg
locationToMsg location =
    location.hash
        |> hashToPage
        |> ChangePage


hashToPage : String -> Page
hashToPage hash =
    case hash of
        "#/login" ->
            LoginPage

        _ ->
            GamePage


pageToHash : Page -> String
pageToHash page =
    case page of
        LoginPage ->
            "#/login"

        GamePage ->
            "#/"


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    let
        page =
            hashToPage location.hash

        ( gameModel, gameCmd ) =
            Game.Update.init

        initialModel =
            { page = page
            , game = gameModel
            , login = ""
            }

        cmds =
            Cmd.batch
                [ Cmd.map GameMsg gameCmd
                ]
    in
        ( initialModel, cmds )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Sub.map GameMsg (Game.Update.subscriptions model.game) ]
