module Router.Update exposing (init, update)

import Browser exposing (UrlRequest(..))
import Browser.Navigation exposing (Key, load, pushUrl)
import Events.Types
import RemoteData exposing (..)
import Return exposing (Return, return)
import Router.Helpers exposing (toPath)
import Router.Routes exposing (..)
import Router.Types exposing (..)
import Tables.Types
import Types
import Url exposing (Url)


init : Url -> Key -> Return Msg Model
init url key =
    return
        { page = parseUrl url
        , key = key
        }
        Cmd.none


update : Types.Msg -> Model -> Return Msg Model
update msgFor model =
    case msgFor of
        Types.MsgForRouter msg ->
            updateRouter msg model

        Types.MsgForEvents (Events.Types.EventCreated _) ->
            updateRouter (Go EventsListPage) model

        Types.MsgForTables (Tables.Types.TableCreated (Success table)) ->
            updateRouter (Go <| TablesListPage table.event) model

        _ ->
            return model Cmd.none


updateRouter : Msg -> Model -> Return Msg Model
updateRouter msg model =
    case msg of
        OnUrlChange url ->
            return { model | page = parseUrl url } Cmd.none

        OnUrlRequest urlRequest ->
            case urlRequest of
                Internal url ->
                    ( model, pushUrl model.key <| Url.toString url )

                External url ->
                    ( model, load url )

        Go page ->
            return model (pushUrl model.key <| toPath page)
