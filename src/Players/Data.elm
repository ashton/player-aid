module Players.Data exposing (getPlayersInTable, playerDecoder)

import Http
import Json.Decode as Decode
import Players.Types exposing (Msg(..), Player, Players)
import RemoteData
import String.Format


playerDecoder : Decode.Decoder Player
playerDecoder =
    let
        map2 =
            Decode.map2

        field =
            Decode.field

        string =
            Decode.string

        maybe =
            Decode.maybe
    in
    map2 Player
        (field "name" string)
        (maybe <| field "phone" string)


playerListDecoder : Decode.Decoder Players
playerListDecoder =
    let
        at =
            Decode.at

        list =
            Decode.list
    in
    at [ "players" ] <| list playerDecoder


getPlayersInTable : String -> String -> Cmd Msg
getPlayersInTable baseUrl tableId =
    let
        url =
            "{{}}/tables/{{}}"
                |> String.Format.value baseUrl
                |> String.Format.value tableId

        resultMsg =
            RemoteData.fromResult >> HandleList
    in
    Http.get
        { url = url
        , expect = Http.expectJson resultMsg playerListDecoder
        }
