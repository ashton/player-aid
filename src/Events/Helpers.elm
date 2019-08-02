module Events.Helpers exposing (updateFormDate, updateFormDescription, updateFormName)

import Events.Types exposing (EventData)


updateFormName : Maybe String -> EventData -> EventData
updateFormName name model =
    { model | name = name }


updateFormDate : Maybe String -> EventData -> EventData
updateFormDate date model =
    { model | date = date }


updateFormDescription : Maybe String -> EventData -> EventData
updateFormDescription description model =
    { model | description = description }
