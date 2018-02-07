module SignUp.Update exposing (..)

import SignUp.Model exposing (..)
import Http exposing (Error)
import Facade.User exposing (signUp)
import Navigation


type Msg
    = OnUsernameInput String
    | OnPasswordInput String
    | SignupButtonClicked
    | SignupResponse (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg, Maybe String )
update msg model =
    case msg of
        OnUsernameInput username ->
            ( { model | username = username }, Cmd.none, Nothing )

        OnPasswordInput password ->
            ( { model | password = password }, Cmd.none, Nothing )

        SignupButtonClicked ->
            ( model, Facade.User.signUp model.username model.password SignupResponse, Nothing )

        SignupResponse (Ok token) ->
            ( initialModel, Navigation.newUrl "#/", Just token )

        SignupResponse (Err err) ->
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
