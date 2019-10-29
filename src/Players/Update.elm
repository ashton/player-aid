module Players.Update exposing (init, update)

import Players.Data exposing (getPlayersInTable)
import Players.Types exposing (Model, Msg(..))
import RemoteData exposing (RemoteData(..))
import Return exposing (Return, return)
import Router.Routes exposing (Page(..), parseUrl)
import Router.Types as RoutingTypes
import Types


init : Return Msg Model
init =
    return Loading Cmd.none


update : Types.Config -> Types.Msg -> Model -> Return Msg Model
update config msgFor model =
    case msgFor of
        Types.MsgForPlayers msg ->
            updatePlayers model msg

        Types.MsgForRouter (RoutingTypes.OnUrlChange url) ->
            case parseUrl url of
                PlayersListPage _ tableId ->
                    return model <| getPlayersInTable config.apiUrl tableId

                _ ->
                    return model Cmd.none

        _ ->
            return model Cmd.none


updatePlayers : Model -> Msg -> Return Msg Model
updatePlayers model msg =
    case msg of
        HandleList players ->
            return players Cmd.none
