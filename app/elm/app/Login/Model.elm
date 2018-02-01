module Login.Model exposing (..)


type alias Model =
    { username : String
    , usernameError : Maybe String
    , password : String
    , passwordError : Maybe String
    }


initialModel : Model
initialModel =
    { username = ""
    , usernameError = Nothing
    , password = ""
    , passwordError = Nothing
    }
