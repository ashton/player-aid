module Types exposing (Config, Model, Msg(..))

import Events.Types
import Feedback.Types
import Players.Types
import Router.Types
import Tables.Types


type alias Config =
    { apiUrl : String
    , auth : Bool
    }


type alias Model =
    { config : Config
    , router : Router.Types.Model
    , tables : Tables.Types.Model
    , events : Events.Types.Model
    , players : Players.Types.Model
    , feedback : Feedback.Types.Model
    }


type Msg
    = MsgForRouter Router.Types.Msg
    | MsgForTables Tables.Types.Msg
    | MsgForEvents Events.Types.Msg
    | MsgForFeedback Feedback.Types.Msg
    | MsgForPlayers Players.Types.Msg
