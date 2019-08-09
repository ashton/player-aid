module Tables.Update exposing (..)

import Return exposing (Return, return)
import Tables.Types exposing (..)
import Types


init : Return Msg Model
init =
    return
        { sample = ""
        }
        Cmd.none


update : Types.Msg -> Model -> Return Msg Model
update msgFor model =
    case msgFor of
        Types.MsgForTables msg ->
            updateTables msg model

        _ ->
            return model Cmd.none


updateTables : Msg -> Model -> Return Msg Model
updateTables msg model =
    case msg of
        NoOp ->
            return model Cmd.none
