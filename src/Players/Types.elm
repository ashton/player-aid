module Players.Types exposing (Model, Msg(..), Player, PlayerData, Players)

import RemoteData exposing (WebData)


type alias PlayerData =
    { name : Maybe String
    , phone : Maybe String
    }


type alias Player =
    { name : String
    , phone : Maybe String
    }


type alias Players =
    List Player


type alias Model =
    { players : WebData Players
    , form : PlayerData
    }


type Msg
    = HandleList (WebData Players)
    | UpdateFormName String
    | UpdateFormPhone String
    | HandleFormSubmit String String
    | PlayerAdded String String (WebData Player)
