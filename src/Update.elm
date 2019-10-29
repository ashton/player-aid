module Update exposing (andMapCmd, init, update)

import Browser.Navigation exposing (Key)
import Events.Update
import Feedback.Update
import Players.Update
import Return exposing (Return, andMap, mapCmd, singleton)
import Router.Update
import Tables.Update
import Types exposing (Config, Model, Msg(..))
import Url exposing (Url)


init : Config -> (Url -> (Key -> Return Msg Model))
init config url key =
    singleton (Model config)
        |> andMapCmd MsgForRouter (Router.Update.init url key)
        |> andMapCmd MsgForTables Tables.Update.init
        |> andMapCmd MsgForEvents (Events.Update.init config)
        |> andMapCmd MsgForPlayers Players.Update.init
        |> andMapCmd MsgForFeedback Feedback.Update.init


update : Msg -> (Model -> Return Msg Model)
update msg model =
    singleton (Model model.config)
        |> andMapCmd MsgForRouter (Router.Update.update msg model.router)
        |> andMapCmd MsgForTables (Tables.Update.update model.config msg model.tables)
        |> andMapCmd MsgForEvents (Events.Update.update model.config msg model.events)
        |> andMapCmd MsgForPlayers (Players.Update.update model.config msg model.players)
        |> andMapCmd MsgForFeedback (Feedback.Update.update msg model.feedback)


andMapCmd : (msg1 -> msg2) -> (Return msg1 model1 -> (Return msg2 (model1 -> model2) -> Return msg2 model2))
andMapCmd msg =
    andMap << mapCmd msg
