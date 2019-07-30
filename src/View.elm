module View exposing (renderRoute, view)

import Browser
import Bulma.CDN exposing (stylesheet)
import Bulma.Components exposing (..)
import Bulma.Layout exposing (SectionSpacing(..))
import Bulma.Modifiers exposing (Color(..))
import Events.View
import Html exposing (Html, div, i, span, text)
import Html.Attributes exposing (class)
import Router.Routes exposing (..)
import Router.Types exposing (Msg(..))
import Tables.View
import Types exposing (..)


view : Model -> Browser.Document Types.Msg
view model =
    { title = "Board Game Event Organizer"
    , body =
        [ div []
            [ stylesheet
            , appbar model.router.page
            , Bulma.Layout.section NotSpaced
                []
                [ renderRoute model
                ]
            ]
        ]
    }


renderRoute : Model -> Html Types.Msg
renderRoute model =
    case model.router.page of
        NotFound ->
            text "404 Not Found"

        TablesPage ->
            Html.map MsgForTables (Tables.View.view model.tables)

        EventsPage ->
            Html.map MsgForEvents (Events.View.view model.events)


appbar : Page -> Html Types.Msg
appbar currentPage =
    navbar { color = Light, transparent = False }
        []
        [ navbarBrand []
            (navbarBurger False
                []
                []
            )
            [ navbarItem False
                []
                [ span [ class "icon" ]
                    [ i [ class "fas fa-gift" ] []
                    ]
                , span [ class "has-text-weight-light" ] [ text "Board Game Event Organizer" ]
                ]
            ]
        , navbarMenu False
            []
            [ navbarStart []
                [ navbarItemLink (currentPage == EventsPage) [] [ text "Events" ]
                ]
            , navbarEnd []
                []
            ]
        ]
