module Events.Types exposing (Event, EventData, Events, Model, Msg(..))

import RemoteData exposing (WebData)


type alias EventData =
    { name : Maybe String
    , date : Maybe String
    , description : Maybe String
    }


type alias Event =
    { id : String
    , name : String
    , date : String
    , description : String
    }


type alias Events =
    WebData (List Event)


type alias Model =
    { events : WebData (List Event)
    , form : EventData
    }


type Msg
    = HandleList Events
    | UpdateFormName String
    | UpdateFormDate String
    | UpdateFormDescription String
    | HandleFormSubmit
    | EventCreated (WebData ())
