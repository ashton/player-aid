module Players.Helpers exposing (playersNotificationFor, updateFormName, updateFormPhone)

import Bulma.Modifiers as Modifiers
import Feedback.Types exposing (Notification)
import Players.Types exposing (Msg(..), PlayerData)
import RemoteData exposing (RemoteData(..))


updateFormName : PlayerData -> String -> PlayerData
updateFormName formData name =
    { formData | name = Just name }


updateFormPhone : PlayerData -> String -> PlayerData
updateFormPhone formData phone =
    { formData | phone = Just phone }


playersNotificationFor : Msg -> Notification
playersNotificationFor msg =
    case msg of
        PlayerAdded _ _ (Success _) ->
            let
                message =
                    "Registration successfull"
            in
            Just { text = message, color = Modifiers.Success }

        _ ->
            Nothing
