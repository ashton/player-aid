module Events.Types exposing (Event, Events, Model, Msg(..))

import RemoteData exposing (WebData)


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
    }


type Msg
    = HandleList Events
