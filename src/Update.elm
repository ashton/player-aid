module Update exposing (andMapCmd, init, update)

import Browser
import Browser.Navigation exposing (Key)
import Events.Update
import Return exposing (Return, andMap, mapCmd, singleton)
import Router.Update
import Tables.Update
import Types exposing (..)
import Url exposing (Url)


init : flags -> (Url -> (Key -> Return Msg Model))
init _ url key =
    singleton Model |> andMapCmd MsgForRouter (Router.Update.init url key) |> andMapCmd MsgForTables Tables.Update.init |> andMapCmd MsgForEvents Events.Update.init


update : Msg -> (Model -> Return Msg Model)
update msg model =
    singleton Model |> andMapCmd MsgForRouter (Router.Update.update msg model.router) |> andMapCmd MsgForTables (Tables.Update.update msg model.tables) |> andMapCmd MsgForEvents (Events.Update.update msg model.events)


andMapCmd : (msg1 -> msg2) -> (Return msg1 model1 -> (Return msg2 (model1 -> model2) -> Return msg2 model2))
andMapCmd msg =
    andMap << mapCmd msg
