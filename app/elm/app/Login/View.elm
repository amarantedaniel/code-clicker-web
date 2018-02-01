module Login.View exposing (..)

import Login.Model exposing (..)
import Login.Update exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


view : Model -> Html Msg
view model =
    div [ class "login-view" ]
        [ h1 [] [ text "LOG IN" ]
        , input [ class "login-view-item", placeholder "Username", value model.username, onInput OnUsernameInput ] []
        , input [ class "login-view-item", placeholder "Password", value model.password, onInput OnPasswordInput ] []
        , button [ class "login-view-item" ] [ text "Login" ]
        ]
