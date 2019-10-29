module Tables.Helpers exposing (getRemainingSpots, tableNotificationFor, updateFormGame, updateFormMaxPlayers)

import Bulma.Modifiers as Modifiers
import Feedback.Types exposing (Notification)
import RemoteData exposing (RemoteData(..))
import String.Format
import Tables.Types exposing (Msg(..), Table, TableData)


getRemainingSpots : Table -> String
getRemainingSpots table =
    let
        remaining =
            table.maxPlayers - List.length table.players
    in
    "{{}}/{{}}"
        |> String.Format.value (String.fromInt remaining)
        |> String.Format.value (String.fromInt table.maxPlayers)


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
