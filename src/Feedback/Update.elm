module Feedback.Update exposing (init, update)

import Bulma.Modifiers as Modifiers
import Debug exposing (toString)
import Events.Types as EventMsgs
import Feedback.Types exposing (Model, Msg(..))
import RemoteData exposing (RemoteData(..))
import Return exposing (Return, return)
import Types


init : Return Msg Model
init =
    return
        { text = Nothing
        , color = Modifiers.Success
        }
        Cmd.none


update : Types.Msg -> Model -> Return Msg Model
update msgFor model =
    case msgFor of
        Types.MsgForEvents msg ->
            eventNotifications msg model

        Types.MsgForFeedback _ ->
            return { model | text = Nothing, color = Modifiers.Default } Cmd.none

        _ ->
            return model Cmd.none


addMessage : String -> Modifiers.Color -> Model -> Return Msg Model
addMessage message color model =
    return { model | text = Just message, color = color } Cmd.none


eventNotifications : EventMsgs.Msg -> Model -> Return Msg Model
eventNotifications msg model =
    case msg of
        EventMsgs.EventCreated result ->
            case result of
                Success event ->
                    model |> addMessage "Event created successfully" Modifiers.Success

                Failure e ->
                    model |> addMessage (toString e) Modifiers.Danger

                _ ->
                    return model Cmd.none

        _ ->
            return model Cmd.none
