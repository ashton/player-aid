module Types exposing (Model, Msg(..))

import Events.Types
import Router.Types
import Tables.Types


type alias Model =
    { router : Router.Types.Model, tables : Tables.Types.Model, events : Events.Types.Model }


type Msg
    = MsgForRouter Router.Types.Msg
    | MsgForTables Tables.Types.Msg
    | MsgForEvents Events.Types.Msg
