module Login.Update exposing (..)

import Login.Model exposing (..)
import Http exposing (Error)
import Facade.User exposing (login)
import Navigation


type Msg
    = OnUsernameInput String
    | OnPasswordInput String
    | LoginButtonClicked
    | LoginResponse (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg, Maybe String )
update msg model =
    case msg of
        OnUsernameInput username ->
            ( { model | username = username }, Cmd.none, Nothing )

        OnPasswordInput password ->
            ( { model | password = password }, Cmd.none, Nothing )

        LoginButtonClicked ->
            ( model, Facade.User.login model.username model.password LoginResponse, Nothing )

        LoginResponse (Ok token) ->
            ( initialModel, Navigation.newUrl "#/", Just token )

        LoginResponse (Err err) ->
            let
                errorMessage =
                    case err of
                        Http.BadStatus response ->
                            response.status.message

                        _ ->
                            "Sign Up Error"
            in
                ( { model | error = Just errorMessage }, Cmd.none, Nothing )


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
