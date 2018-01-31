module StoreFacade exposing (fetchItems)

import Model exposing (..)
import Http
import Json.Decode exposing (Decoder, list, string, float, int)
import Json.Decode.Pipeline exposing (decode, required, hardcoded)


fetchItems : (Result Http.Error (List StoreItem) -> msg) -> Cmd msg
fetchItems msg =
    Http.request
        { method = "GET"
        , headers = []
        , url = "http://localhost:4000/api/items"
        , body = Http.emptyBody
        , expect =
            Http.expectStringResponse (\response -> Json.Decode.decodeString itemListDecoder response.body)
        , timeout = Nothing
        , withCredentials = False
        }
        |> Http.send msg


itemListDecoder : Decoder (List StoreItem)
itemListDecoder =
    (list itemDecoder)


itemDecoder : Decoder StoreItem
itemDecoder =
    decode StoreItem
        |> required "name" string
        |> required "base_price" int
        |> required "clicks_per_second" int
        |> required "price_multiplier" float
        |> hardcoded 0
