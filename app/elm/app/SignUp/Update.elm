module SignUp.Update exposing (..)

import SignUp.Model exposing (..)


type Msg
    = OnUsernameInput String
    | OnPasswordInput String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnUsernameInput username ->
            ( { model | username = username }, Cmd.none )

        OnPasswordInput password ->
            ( { model | password = password }, Cmd.none )


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
