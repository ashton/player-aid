module Tables.Data exposing (createTableForEvent, getEventTables)

import Http
import Json.Decode as Decode
import Json.Encode as Encode
import Json.Encode.Extra exposing (maybe)
import Players.Data exposing (playerDecoder)
import RemoteData
import String.Format
import Tables.Types exposing (Msg(..), Table, TableData)


tableEncoder : TableData -> Encode.Value
tableEncoder formData =
    let
        object =
            Encode.object

        int =
            Encode.int

        string =
            Encode.string
    in
    object
        [ ( "game", maybe string formData.game )
        , ( "maxPlayers", maybe int formData.maxPlayers )
        ]


tableListDecoder : Decode.Decoder (List Table)
tableListDecoder =
    let
        list =
            Decode.list
    in
    list tableDecoder


tableDecoder : Decode.Decoder Table
tableDecoder =
    let
        map5 =
            Decode.map5

        field =
            Decode.field

        string =
            Decode.string

        int =
            Decode.int

        at =
            Decode.at

        list =
            Decode.list
    in
    map5 Table
        (field "id" string)
        (field "game" string)
        (field "maxPlayers" int)
        (field "event" string)
        (at [ "players" ] <| list playerDecoder)


getEventTables : String -> String -> Cmd Msg
getEventTables baseUrl eventId =
    let
        url =
            "{{}}/events/{{}}/tables"
                |> String.Format.value baseUrl
                |> String.Format.value eventId

        resultMsg =
            RemoteData.fromResult >> HandleList
    in
    Http.get
        { url = url
        , expect = Http.expectJson resultMsg tableListDecoder
        }


createTableForEvent : String -> String -> TableData -> Cmd Msg
createTableForEvent eventId baseUrl formData =
    let
        url =
            "{{}}/events/{{}}/tables"
                |> String.Format.value baseUrl
                |> String.Format.value eventId

        returnMsg =
            RemoteData.fromResult >> TableCreated
    in
    Http.post
        { url = url
        , body = Http.jsonBody <| tableEncoder formData
        , expect = Http.expectJson returnMsg tableDecoder
        }
