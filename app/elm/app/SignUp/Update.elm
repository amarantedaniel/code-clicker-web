module SignUp.Update exposing (..)

import SignUp.Model exposing (..)
import Http exposing (Error)
import Facade.User exposing (signUp)


type Msg
    = OnUsernameInput String
    | OnPasswordInput String
    | SignupButtonClicked
    | SignupResponse (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnUsernameInput username ->
            ( { model | username = username }, Cmd.none )

        OnPasswordInput password ->
            ( { model | password = password }, Cmd.none )

        SignupButtonClicked ->
            ( model, Facade.User.signUp model.username model.password SignupResponse )

        SignupResponse (Ok token) ->
            ( model, Cmd.none )

        SignupResponse (Err err) ->
            let
                errorMessage =
                    case err of
                        Http.BadStatus response ->
                            response.status.message

                        _ ->
                            "Sign Up Error"
            in
                ( { model | error = Just errorMessage }, Cmd.none )


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
