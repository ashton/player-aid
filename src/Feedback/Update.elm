module Feedback.Update exposing (init, update, updateFeedback)

import Bulma.Modifiers exposing (Color(..))
import Feedback.Types exposing (..)
import Return exposing (Return, return)
import Types


init : Return Msg Model
init =
    return
        { text = Nothing
        , color = Success
        }
        Cmd.none


update : Types.Msg -> Model -> Return Msg Model
update msgFor model =
    case msgFor of
        Types.MsgForFeedback msg ->
            updateFeedback msg model

        _ ->
            return model Cmd.none


updateFeedback : Msg -> Model -> Return Msg Model
updateFeedback msg model =
    case msg of
        NoOp ->
            return model Cmd.none
