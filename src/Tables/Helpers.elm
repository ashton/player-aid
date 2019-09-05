module Tables.Helpers exposing (updateFormGame)

import Tables.Types exposing (TableData)


updateFormGame : Maybe String -> TableData -> TableData
updateFormGame game model =
    { model | game = game }


updateFormMaxPlayers : Maybe String -> TableData -> TableData
updateFormMaxPlayers maxPlayers model =
    { model | maxPlayers = maxPlayers }
