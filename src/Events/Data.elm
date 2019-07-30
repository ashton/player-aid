module Events.Data exposing (eventDecoder, eventListDecoder, getEvents)

import Events.Types exposing (Event, Msg(..))
import Http
import Json.Decode exposing (Decoder, field, list, map4, string)
import RemoteData


eventDecoder : Decoder Event
eventDecoder =
    map4 Event
        (field "id" string)
        (field "name" string)
        (field "date" string)
        (field "description" string)


eventListDecoder : Decoder (List Event)
eventListDecoder =
    list eventDecoder


getEvents : String -> Cmd Msg
getEvents baseUrl =
    let
        url =
            baseUrl ++ "/events"

        resultMsg =
            RemoteData.fromResult >> HandleList
    in
    Http.get
        { url = url
        , expect =
            Http.expectJson
                resultMsg
                eventListDecoder
        }
