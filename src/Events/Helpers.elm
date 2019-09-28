module Events.Helpers exposing (eventNotificationFor, updateFormDate, updateFormDescription, updateFormName)

import Bulma.Modifiers as Modifiers
import Debug exposing (toString)
import Events.Types exposing (EventData, Msg(..))
import Feedback.Types exposing (Notification)
import RemoteData exposing (RemoteData(..))
import String.Format


updateFormName : Maybe String -> EventData -> EventData
updateFormName name model =
    { model | name = name }


updateFormDate : Maybe String -> EventData -> EventData
updateFormDate date model =
    { model | date = date }


updateFormDescription : Maybe String -> EventData -> EventData
updateFormDescription description model =
    { model | description = description }


eventNotificationFor : Msg -> Notification
eventNotificationFor msg =
    case msg of
        EventCreated (Success event) ->
            let
                message =
                    "Event {{}} created successfully" |> String.Format.value event.name
            in
            Just { text = message, color = Modifiers.Success }

        EventCreated (Failure error) ->
            Just { text = toString error, color = Modifiers.Danger }

        _ ->
            Nothing
