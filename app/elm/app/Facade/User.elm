module Facade.User exposing (..)

import Http
import Json.Encode
import Json.Decode


signUp : String -> String -> (Result Http.Error String -> msg) -> Cmd msg
signUp username password msg =
    Http.request
        { method = "POST"
        , headers = []
        , url = "http://localhost:4000/api/users/signup"
        , body = encodeCredentials username password
        , expect =
            Http.expectStringResponse (\response -> Json.Decode.decodeString tokenDecoder response.body)
        , timeout = Nothing
        , withCredentials = False
        }
        |> Http.send msg


login : String -> String -> (Result Http.Error String -> msg) -> Cmd msg
login username password msg =
    Http.request
        { method = "POST"
        , headers = []
        , url = "http://localhost:4000/api/users/login"
        , body = encodeCredentials username password
        , expect =
            Http.expectStringResponse (\response -> Json.Decode.decodeString tokenDecoder response.body)
        , timeout = Nothing
        , withCredentials = False
        }
        |> Http.send msg


encodeCredentials : String -> String -> Http.Body
encodeCredentials username password =
    Json.Encode.object
        [ ( "username", Json.Encode.string username )
        , ( "password", Json.Encode.string password )
        ]
        |> Json.Encode.encode 0
        |> Http.stringBody "application/json"


tokenDecoder : Json.Decode.Decoder String
tokenDecoder =
    Json.Decode.at [ "token" ] Json.Decode.string
