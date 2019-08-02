module Events.Data exposing (createEvent, eventDecoder, eventListDecoder, getEvents)

import Events.Types exposing (Event, EventData, Msg(..))
import Http
import Json.Decode as Decode
import Json.Encode as Encode
import Json.Encode.Extra exposing (maybe)
import RemoteData


eventDecoder : Decode.Decoder Event
eventDecoder =
    let
        map4 =
            Decode.map4

        field =
            Decode.field

        string =
            Decode.string
    in
    map4 Event
        (field "id" string)
        (field "name" string)
        (field "date" string)
        (field "description" string)


eventEncoder : EventData -> Encode.Value
eventEncoder data =
    let
        object =
            Encode.object

        string =
            Encode.string
    in
    object
        [ ( "name", maybe string data.name )
        , ( "date", maybe string data.date )
        , ( "description", maybe string data.description )
        ]


eventListDecoder : Decode.Decoder (List Event)
eventListDecoder =
    let
        list =
            Decode.list
    in
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


createEvent : String -> EventData -> Cmd Msg
createEvent baseUrl data =
    let
        url =
            baseUrl ++ "/events"

        resultMsg =
            RemoteData.fromResult >> EventCreated
    in
    Http.post
        { url = url
        , body = Http.jsonBody (eventEncoder data)
        , expect = Http.expectWhatever resultMsg
        }
