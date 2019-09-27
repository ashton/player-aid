module Tables.Data exposing (getEventTables)

import Http
import Json.Decode as Decode
import Json.Encode as Encode
import Json.Encode.Extra exposing (maybe)
import RemoteData
import String.Format
import Tables.Types exposing (Msg(..), Table, TableData)


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
        map4 =
            Decode.map4

        field =
            Decode.field

        string =
            Decode.string

        int =
            Decode.int
    in
    map4 Table
        (field "id" string)
        (field "game" string)
        (field "maxPlayers" int)
        (field "event" string)


getEventTables : String -> String -> Cmd Msg
getEventTables baseUrl eventId =
    let
        url =
            "{{}}/events/{{}}/tables" |> String.Format.value baseUrl |> String.Format.value eventId

        resultMsg =
            RemoteData.fromResult >> HandleList
    in
    Http.get
        { url = url
        , expect = Http.expectJson resultMsg tableListDecoder
        }
