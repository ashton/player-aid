module View exposing (renderRoute, view)

import Browser
import Bulma.CDN exposing (stylesheet)
import Bulma.Components exposing (navbar, navbarBrand, navbarBurger, navbarEnd, navbarItem, navbarItemLink, navbarMenu, navbarStart)
import Bulma.Layout exposing (SectionSpacing(..))
import Bulma.Modifiers exposing (Color(..))
import Events.View
import Feedback.View
import Html exposing (Html, div, i, span, text)
import Html.Attributes exposing (class)
import Router.Routes exposing (Page(..))
import Router.Types exposing (Msg(..))
import Tables.View
import Types exposing (Model, Msg(..))


view : Model -> Browser.Document Types.Msg
view model =
    { title = "Board Game Event Organizer"
    , body =
        [ div []
            [ stylesheet
            , appbar model.router.page
            , Bulma.Layout.section NotSpaced
                []
                [ renderFeedback model
                , renderRoute model
                ]
            ]
        ]
    }


renderFeedback : Model -> Html Types.Msg
renderFeedback model =
    Html.map MsgForFeedback (Feedback.View.view model.feedback)


renderRoute : Model -> Html Types.Msg
renderRoute model =
    case model.router.page of
        NotFound ->
            text "404 Not Found"

        TablesListPage eventId ->
            Html.map MsgForTables (Tables.View.listView eventId model.tables)

        TablesFormPage _ ->
            text "not implemented"

        EventsListPage ->
            Html.map MsgForEvents (Events.View.listView model.events)

        EventsFormPage ->
            Html.map MsgForEvents (Events.View.formView model.events)


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
                    [ i [ class "fas fa-dice" ] [] ]
                , span [ class "has-text-weight-light" ] [ text "Player Aid" ]
                ]
            ]
        , navbarMenu False
            []
            [ navbarStart []
                [ navbarItemLink (currentPage == EventsListPage) [] [ text "Events" ] ]
            , navbarEnd []
                []
            ]
        ]
