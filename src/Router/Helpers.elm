module Router.Helpers exposing (changeRoute, toPath)

import Router.Routes exposing (Page(..))
import Router.Types exposing (Msg(..))
import String.Format
import Types exposing (Msg(..))


toPath : Page -> String
toPath page =
    case page of
        NotFound ->
            "/404"

        TablesListPage eventId ->
            "/events/{{  }}/tables" |> String.Format.value eventId

        TablesFormPage eventId ->
            "/events/{{  }}/tables/new" |> String.Format.value eventId

        EventsListPage ->
            "/events"

        EventsFormPage ->
            "/events/new"

        PlayersListPage eventId tableId ->
            "/events/{{  }}/tables/{{  }}/players"
                |> String.Format.value eventId
                |> String.Format.value tableId


changeRoute : Page -> Types.Msg
changeRoute =
    MsgForRouter << Go
