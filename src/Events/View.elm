module Events.View exposing (view)

import Bulma.Elements exposing (table, tableBody, tableCell, tableCellHead, tableHead, tableModifiers, tableRow)
import Events.Types exposing (..)
import Html exposing (Html, text)
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
        Success eventList ->
            tableBody [] (renderEvents eventList)

        _ ->
            tableBody [] []


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
