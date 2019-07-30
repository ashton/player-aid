module Events.Update exposing (init, update, updateEvents)

import Events.Data exposing (getEvents)
import Events.Types exposing (Model, Msg(..))
import RemoteData exposing (RemoteData(..))
import Return exposing (Return, return)
import Types


init : Types.Config -> Return Msg Model
init config =
    let
        model =
            { events = Loading }

        command =
            getEvents config.apiUrl
    in
    return model command


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
        HandleList events ->
            return { model | events = events } Cmd.none
