module Router.Routes exposing (Page(..), parseUrl, routes)

import Url exposing (Url)
import Url.Parser exposing ((</>), Parser, map, oneOf, parse, s, string, top)


type Page
    = NotFound
    | TablesListPage String
    | TablesFormPage String
    | EventsListPage
    | EventsFormPage
    | PlayersListPage String String
    | AddPlayerFormPage String String


routes : Parser (Page -> a) a
routes =
    oneOf
        [ map EventsListPage top
        , map NotFound (s "404")
        , map TablesListPage (s "events" </> string </> s "tables")
        , map TablesFormPage (s "events" </> string </> s "tables" </> s "new")
        , map EventsListPage (s "events")
        , map EventsFormPage (s "events" </> s "new")
        , map PlayersListPage (s "events" </> string </> s "tables" </> string </> s "players")
        , map AddPlayerFormPage (s "events" </> string </> s "tables" </> string </> s "players" </> s "add")
        ]


parseUrl : Url -> Page
parseUrl url =
    Maybe.withDefault NotFound <| parse routes url
