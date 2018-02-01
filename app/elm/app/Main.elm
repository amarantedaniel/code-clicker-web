module Main exposing (..)

import Game.Model
import Game.Update
import Game.View
import Login.Model
import Login.Update
import Login.View
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
    , login : Login.Model.Model
    }



-- UPDATE --


type Msg
    = ChangePage Page
    | GameMsg Game.Update.Msg
    | LoginMsg Login.Update.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangePage page ->
            ( { model | page = page }, Cmd.none )

        GameMsg gameMsg ->
            let
                ( gameModel, gameCmd ) =
                    Game.Update.update gameMsg model.game
            in
                ( { model | game = gameModel }, Cmd.map GameMsg gameCmd )

        LoginMsg loginMsg ->
            let
                ( loginModel, loginCmd ) =
                    Login.Update.update loginMsg model.login
            in
                ( { model | login = loginModel }, Cmd.map LoginMsg loginCmd )



-- VIEW --


view : Model -> Html Msg
view model =
    let
        page =
            case model.page of
                GamePage ->
                    Html.map GameMsg (Game.View.view model.game)

                LoginPage ->
                    Html.map LoginMsg (Login.View.view model.login)
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

        ( loginModel, loginCmd ) =
            Login.Update.init

        initialModel =
            { page = page
            , game = gameModel
            , login = loginModel
            }

        cmds =
            Cmd.batch
                [ Cmd.map GameMsg gameCmd
                , Cmd.map LoginMsg loginCmd
                ]
    in
        ( initialModel, cmds )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Sub.map GameMsg (Game.Update.subscriptions model.game) ]
