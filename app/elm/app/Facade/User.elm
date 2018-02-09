module Facade.User exposing (..)

import Http
import Json.Encode
import Json.Decode
import Json.Decode.Pipeline exposing (..)


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


save : String -> Int -> (Result Http.Error () -> msg) -> Cmd msg
save token linesCount msg =
    Http.request
        { method = "POST"
        , headers = [ Http.header "Authorization" (token) ]
        , url = "http://localhost:4000/api/users/save"
        , body = encodeGameState linesCount
        , expect =
            Http.expectStringResponse (\_ -> Ok ())
        , timeout = Nothing
        , withCredentials = False
        }
        |> Http.send msg


encodeGameState : Int -> Http.Body
encodeGameState linesCount =
    Json.Encode.object
        [ ( "lines_count", Json.Encode.int linesCount ) ]
        |> Json.Encode.encode 0
        |> Http.stringBody "application/json"


type alias MeResponse =
    { numberOfClicks : Int
    }


me : String -> (Result Http.Error MeResponse -> msg) -> Cmd msg
me token msg =
    Http.request
        { method = "GET"
        , headers = [ Http.header "Authorization" (token) ]
        , url = "http://localhost:4000/api/users/me"
        , body = Http.emptyBody
        , expect =
            Http.expectStringResponse (\response -> Json.Decode.decodeString meDecoder response.body)
        , timeout = Nothing
        , withCredentials = False
        }
        |> Http.send msg


meDecoder : Json.Decode.Decoder MeResponse
meDecoder =
    decode MeResponse
        |> required "lines_count" Json.Decode.int
