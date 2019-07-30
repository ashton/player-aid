module Events.View exposing (view)

import Bulma.Elements exposing (table, tableBody, tableCell, tableCellHead, tableHead, tableModifiers, tableRow)
import Events.Types exposing (Event, Model, Msg(..))
import Html exposing (Html, i, text)
import Html.Attributes exposing (class, colspan)
import RemoteData exposing (RemoteData(..))


view : Model -> Html Msg
view model =
    table tableModifiers
        []
        [ tableHeader
        , tableContent model
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
