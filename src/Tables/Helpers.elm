module Tables.Helpers exposing (tableNotificationFor, updateFormGame, updateFormMaxPlayers)

import Bulma.Modifiers as Modifiers
import Feedback.Types exposing (Notification)
import RemoteData exposing (RemoteData(..))
import String.Format
import Tables.Types exposing (Msg(..), TableData)


updateFormGame : Maybe String -> TableData -> TableData
updateFormGame game model =
    { model | game = game }


updateFormMaxPlayers : Maybe String -> TableData -> TableData
updateFormMaxPlayers maxPlayers model =
    { model | maxPlayers = Maybe.andThen String.toInt maxPlayers }


tableNotificationFor : Msg -> Notification
tableNotificationFor msg =
    case msg of
        TableCreated (Success table) ->
            let
                message =
                    "Table of {{}} created successfully" |> String.Format.value table.game
            in
            Just { text = message, color = Modifiers.Success }

        _ ->
            Nothing
