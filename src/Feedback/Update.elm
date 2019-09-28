module Feedback.Update exposing (init, update)

import Bulma.Modifiers as Modifiers
import Events.Helpers exposing (eventNotificationFor)
import Feedback.Helpers exposing (addMessage)
import Feedback.Types exposing (Model, Msg(..))
import RemoteData exposing (RemoteData(..))
import Return exposing (Return, return)
import Tables.Helpers exposing (tableNotificationFor)
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
    let
        nothingHappens =
            return model Cmd.none
    in
    case msgFor of
        Types.MsgForEvents msg ->
            case eventNotificationFor msg of
                Just { text, color } ->
                    addMessage text color model

                _ ->
                    nothingHappens

        Types.MsgForTables msg ->
            case tableNotificationFor msg of
                Just { text, color } ->
                    addMessage text color model

                _ ->
                    nothingHappens

        Types.MsgForFeedback _ ->
            return { model | text = Nothing, color = Modifiers.Default } Cmd.none

        _ ->
            nothingHappens
