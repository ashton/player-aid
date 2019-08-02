module Events.Views.List exposing (view)

import Bulma.Elements exposing (button, buttonModifiers, table, tableBody, tableCell, tableCellHead, tableFoot, tableHead, tableModifiers, tableRow)
import Bulma.Modifiers as Modifiers
import Events.Types exposing (Event, Model, Msg(..))
import Html exposing (Html, i, text)
import Html.Attributes exposing (class, colspan, href)
import RemoteData exposing (RemoteData(..))
import Router.Helpers exposing (toPath)
import Router.Routes exposing (Page(..))


view : Model -> Html Msg
view model =
    table tableModifiers
        []
        [ tableHeader
        , tableContent model
        , tableFooter
        ]


tableHeader : Html Msg
tableHeader =
    tableHead []
        [ tableRow False
            []
            [ tableCellHead [] [ text "Name" ]
            , tableCellHead [] [ text "Date" ]
            , tableCellHead [] [ text "Description" ]
            ]
        ]


tableContent : Model -> Html Msg
tableContent model =
    case model.events of
        Loading ->
            tableBody [] [ loading ]

        Success eventList ->
            tableBody [] (renderEvents eventList)

        _ ->
            tableBody [] []


loading : Html Msg
loading =
    tableRow False
        []
        [ tableCell [ colspan 3, class "has-text-centered" ]
            [ i [ class "fas fa-2x fa-spinner fa-pulse" ] []
            ]
        ]


tableFooter : Html Msg
tableFooter =
    let
        modifiers =
            { buttonModifiers | color = Modifiers.Primary }
    in
    tableFoot []
        [ tableRow False
            []
            [ tableCellHead [ colspan 3, class "has-text-right" ]
                [ button modifiers [ href (toPath EventsFormPage) ] [ text "New" ]
                ]
            ]
        ]


renderEvents : List Event -> List (Html Msg)
renderEvents events =
    List.map renderEvent events


renderEvent : Event -> Html Msg
renderEvent event =
    tableRow False
        []
        [ tableCell [] [ text event.name ]
        , tableCell [] [ text event.date ]
        , tableCell [] [ text event.description ]
        ]
