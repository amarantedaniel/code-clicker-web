module SignUp.Model exposing (..)


type alias Model =
    { username : String
    , password : String
    , error : Maybe String
    }


initialModel : Model
initialModel =
    { username = ""
    , password = ""
    , error = Nothing
    }
