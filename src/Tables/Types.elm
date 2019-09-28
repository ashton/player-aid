module Tables.Types exposing (Model, Msg(..), Table, TableData, Tables)

import RemoteData exposing (WebData)


type alias Table =
    { id : String
    , game : String
    , maxPlayers : Int
    , event : String
    }


type alias Tables =
    WebData (List Table)


type alias TableData =
    { game : Maybe String
    , maxPlayers : Maybe Int
    , event : Maybe String
    }


type alias Model =
    { form : TableData
    , tables : Tables
    }


type Msg
    = HandleList Tables
    | UpdateFormGame String
    | UpdateFormMaxPlayers String
    | HandleFormSubmit String
    | TableCreated (WebData Table)
