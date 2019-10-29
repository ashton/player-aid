module Players.Types exposing (Model, Msg(..), Player, Players)

import RemoteData exposing (WebData)


type alias Player =
    { name : String
    , phone : Maybe String
    }


type alias Players =
    List Player


type alias Model =
    WebData Players


type Msg
    = HandleList (WebData Players)
