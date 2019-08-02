module Router.Routes exposing (Page(..), routes)

import Url.Parser exposing ((</>), Parser, map, oneOf, s, top)


type Page
    = NotFound
    | TablesPage
    | EventsListPage
    | EventsFormPage


routes : Parser (Page -> a) a
routes =
    oneOf
        [ map EventsListPage top
        , map NotFound (s "404")
        , map TablesPage (s "tables")
        , map EventsListPage (s "events")
        , map EventsFormPage (s "events" </> s "new")
        ]
