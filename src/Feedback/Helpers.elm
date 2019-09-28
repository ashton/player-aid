module Feedback.Helpers exposing (addMessage)

import Bulma.Modifiers as Modifiers
import Feedback.Types exposing (Model, Msg(..))
import Return exposing (Return, return)


addMessage : String -> Modifiers.Color -> Model -> Return Msg Model
addMessage message color model =
    return { model | text = Just message, color = color } Cmd.none
