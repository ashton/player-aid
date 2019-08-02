module Router.Helpers exposing (changeRoute, toPath)

import Router.Routes exposing (Page(..))
import Router.Types exposing (Msg(..))
import Types exposing (Msg(..))


toPath : Page -> String
toPath page =
    case page of
        NotFound ->
            "/404"

        TablesPage ->
            "/tables"

        EventsListPage ->
            "/events"

        EventsFormPage ->
            "/events/new"


changeRoute : Page -> Types.Msg
changeRoute =
    MsgForRouter << Go
