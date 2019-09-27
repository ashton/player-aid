module Tables.Views.List exposing (view)

import Bulma.Elements exposing (button, buttonModifiers, table, tableBody, tableCell, tableCellHead, tableFoot, tableHead, tableModifiers, tableRow)
import Bulma.Modifiers as Modifiers
import Html exposing (Html, a, i, text)
import Html.Attributes exposing (class, colspan, href)
import RemoteData exposing (RemoteData(..))
import Router.Helpers exposing (toPath)
import Router.Routes exposing (Page(..))
import Tables.Types exposing (Model, Msg(..), Table, Tables)


view : String -> Tables -> Html Msg
view eventId tables =
    table tableModifiers
        []
        [ tableHeader
        , tableContent tables
        , tableFooter
        ]


tableHeader : Html Msg
tableHeader =
    tableHead []
        [ tableRow False
            []
            [ tableCellHead [] [ text "Game" ]
            , tableCellHead [] [ text "Max Players" ]
            , tableCellHead [] [ text "Full" ]
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


renderTables : List Table -> List (Html Msg)
renderTables tables =
    List.map renderTable tables


renderTable : Table -> Html Msg
renderTable table =
    tableRow False
        []
        [ tableCell [] [ text table.game ]
        , tableCell [] [ text <| String.fromInt <| table.maxPlayers ]
        , tableCell [] [ text "No" ]
        ]
