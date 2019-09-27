module Tables.Update exposing (init, update, updateTables)

import RemoteData exposing (RemoteData(..))
import Return exposing (Return, return)
import Router.Routes exposing (Page(..), parseUrl)
import Router.Types exposing (Msg(..))
import Tables.Data exposing (getEventTables)
import Tables.Helpers exposing (updateFormGame, updateFormMaxPlayers)
import Tables.Types exposing (Model, Msg(..), TableData)
import Types


init : Return Msg Model
init =
    let
        model =
            { tables = Loading
            , form =
                { game = Nothing
                , maxPlayers = Nothing
                , event = Nothing
                }
            }
    in
    return model Cmd.none


update : Types.Config -> Types.Msg -> Model -> Return Msg Model
update config msgFor model =
    case msgFor of
        Types.MsgForTables msg ->
            updateTables msg model

        Types.MsgForRouter (OnUrlChange url) ->
            case parseUrl url of
                TablesListPage event ->
                    return model <| getEventTables config.apiUrl event

                _ ->
                    return model Cmd.none

        _ ->
            return model Cmd.none


updateTables : Msg -> Model -> Return Msg Model
updateTables msg model =
    case msg of
        HandleList tables ->
            return { model | tables = tables } Cmd.none

        UpdateFormGame game ->
            let
                updatedForm =
                    updateFormGame (Just game) model.form
            in
            return { model | form = updatedForm } Cmd.none

        UpdateFormMaxPlayers maxPlayers ->
            let
                updatedForm =
                    updateFormMaxPlayers (Just maxPlayers) model.form
            in
            return { model | form = updatedForm } Cmd.none
