module Tables.Types exposing (Model, Msg(..), TableData)


type alias TableData =
    { game : Maybe String
    , maxPlayers : Maybe Int
    , event : Maybe String
    }


type alias Model =
    { form : TableData
    }


type Msg
    = UpdateFormGame String
    | UpdateFormMaxPlayers String
