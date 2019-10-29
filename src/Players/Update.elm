module Players.Update exposing (init, update)

import Players.Data exposing (addPlayerToTable, getPlayersInTable)
import Players.Helpers exposing (updateFormName, updateFormPhone)
import Players.Types exposing (Model, Msg(..))
import RemoteData exposing (RemoteData(..))
import Return exposing (Return, return)
import Router.Routes exposing (Page(..), parseUrl)
import Router.Types as RoutingTypes
import Types


init : Return Msg Model
init =
    let
        model =
            { players = Loading
            , form =
                { name = Nothing
                , phone = Nothing
                }
            }
    in
    return model Cmd.none


update : Types.Config -> Types.Msg -> Model -> Return Msg Model
update config msgFor model =
    case msgFor of
        Types.MsgForPlayers msg ->
            updatePlayers config model msg

        Types.MsgForRouter (RoutingTypes.OnUrlChange url) ->
            case parseUrl url of
                PlayersListPage _ tableId ->
                    return model <| getPlayersInTable config.apiUrl tableId

                _ ->
                    return model Cmd.none

        _ ->
            return model Cmd.none


updatePlayers : Types.Config -> Model -> Msg -> Return Msg Model
updatePlayers config model msg =
    case msg of
        HandleList players ->
            return { model | players = players } Cmd.none

        UpdateFormName name ->
            let
                updatedForm =
                    updateFormName model.form name
            in
            return { model | form = updatedForm } Cmd.none

        UpdateFormPhone phone ->
            let
                updatedForm =
                    updateFormPhone model.form phone
            in
            return { model | form = updatedForm } Cmd.none

        HandleFormSubmit eventId tableId ->
            return model <| addPlayerToTable config.apiUrl eventId tableId model.form

        _ ->
            return model Cmd.none
