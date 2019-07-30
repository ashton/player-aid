module Router.Routes exposing (Page(..), routes, toPath)

import Url.Parser exposing (Parser, map, oneOf, s, top)


type Page
    = NotFound
    | TablesPage
    | EventsPage


routes : Parser (Page -> a) a
routes =
    oneOf
        [ map EventsPage top
        , map NotFound (s "404")
        , map TablesPage (s "tables")
        , map EventsPage (s "events")
        ]


toPath : Page -> String
toPath page =
    case page of
        NotFound ->
            "/404"

        TablesPage ->
            "/tables"

        EventsPage ->
            "/events"
