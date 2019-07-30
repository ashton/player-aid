module Events.Update exposing (init, update, updateEvents)

import Events.Types exposing (Event, Model, Msg(..))
import RemoteData exposing (RemoteData(..))
import Return exposing (Return, return)
import Types


init : Return Msg Model
init =
    return
        { events = NotAsked
        }
        Cmd.none


update : Types.Msg -> Model -> Return Msg Model
update msgFor model =
    case msgFor of
        Types.MsgForEvents msg ->
            updateEvents msg model

        _ ->
            return model Cmd.none


updateEvents : Msg -> Model -> Return Msg Model
updateEvents msg model =
    case msg of
        _ ->
            return model Cmd.none
