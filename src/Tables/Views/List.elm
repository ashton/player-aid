module Tables.Views.List exposing (view)

import Bulma.Elements exposing (button, buttonModifiers, table, tableBody, tableCell, tableCellHead, tableFoot, tableHead, tableModifiers, tableRow)
import Bulma.Modifiers as Modifiers
import Html exposing (Html, a, i, text)
import Html.Attributes exposing (class, colspan, href)
import RemoteData exposing (RemoteData(..))
import Router.Helpers exposing (toPath)
import Router.Routes exposing (Page(..))
import Tables.Helpers exposing (getRemainingSpots)
import Tables.Types exposing (Msg(..), Table, Tables)


view : String -> Tables -> Html Msg
view eventId tables =
    table tableModifiers
        []
        [ tableHeader
        , tableContent tables
        , tableFooter eventId
        ]


tableHeader : Html Msg
tableHeader =
    tableHead []
        [ tableRow False
            []
            [ tableCellHead [] [ text "Game" ]
            , tableCellHead [] [ text "Remaning Spots" ]
            ]
        ]


tableContent : Tables -> Html Msg
tableContent tables =
    case tables of
        Loading ->
            tableBody [] [ loading ]

        Success tableList ->
            tableBody [] (renderTables tableList)

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


tableFooter : String -> Html Msg
tableFooter eventId =
    let
        modifiers =
            { buttonModifiers | color = Modifiers.Primary }
    in
    tableFoot []
        [ tableRow False
            []
            [ tableCellHead [ colspan 3, class "has-text-right" ]
                [ button modifiers [ href (toPath <| TablesFormPage eventId) ] [ text "Create" ]
                ]
            ]
        ]


renderTables : List Table -> List (Html Msg)
renderTables tables =
    case tables of
        [] ->
            List.singleton renderEmpty

        _ ->
            List.map renderTable tables


renderEmpty : Html Msg
renderEmpty =
    tableRow False
        []
        [ tableCell [ colspan 2 ] [ text "No tables in this event yet." ]
        ]


renderTable : Table -> Html Msg
renderTable table =
    tableRow False
        []
        [ tableCell []
            [ a [ href <| toPath <| PlayersListPage table.event table.id ]
                [ text table.game
                ]
            ]
        , tableCell [] [ text <| getRemainingSpots table ]
        ]
