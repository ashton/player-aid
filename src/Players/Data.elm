module Players.Data exposing (addPlayerToTable, getPlayersInTable, playerDecoder)

import Http
import Json.Decode as Decode
import Json.Encode as Encode
import Json.Encode.Extra exposing (maybe)
import Players.Types exposing (Msg(..), Player, PlayerData, Players)
import RemoteData
import String.Format


playerEncoder : PlayerData -> Encode.Value
playerEncoder formData =
    let
        object =
            Encode.object

        string =
            Encode.string
    in
    object
        [ ( "name", maybe string formData.name )
        , ( "phone", maybe string formData.phone )
        ]


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


addPlayerToTable : String -> String -> String -> PlayerData -> Cmd Msg
addPlayerToTable baseUrl eventId tableId formData =
    let
        url =
            "{{}}/tables/{{}}/players"
                |> String.Format.value baseUrl
                |> String.Format.value tableId

        returnMsg =
            RemoteData.fromResult >> PlayerAdded eventId tableId
    in
    Http.post
        { url = url
        , body = Http.jsonBody <| playerEncoder formData
        , expect = Http.expectJson returnMsg playerDecoder
        }
