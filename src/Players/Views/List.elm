module Players.Views.List exposing (view)

import Bulma.Elements exposing (button, buttonModifiers, table, tableBody, tableCell, tableCellHead, tableFoot, tableHead, tableModifiers, tableRow)
import Bulma.Modifiers as Modifiers
import Html exposing (Html, a, i, text)
import Html.Attributes exposing (class, colspan, href)
import Players.Types exposing (Msg(..), Player, Players)
import RemoteData exposing (RemoteData(..), WebData)
import Router.Helpers exposing (toPath)
import Router.Routes exposing (Page(..))


view : String -> String -> WebData Players -> Html Msg
view eventId tableId model =
    table tableModifiers
        []
        [ tableHeader
        , tableContent model
        , tableFooter eventId tableId
        ]


tableHeader : Html Msg
tableHeader =
    tableHead []
        [ tableRow False
            []
            [ tableCellHead [] [ text "Name" ]
            , tableCellHead [] [ text "Phone" ]
            ]
        ]


tableContent : WebData Players -> Html Msg
tableContent model =
    case model of
        Loading ->
            tableBody [] [ loading ]

        Success playersList ->
            tableBody [] (renderPlayers playersList)

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


tableFooter : String -> String -> Html Msg
tableFooter eventId tableId =
    let
        modifiers =
            { buttonModifiers | color = Modifiers.Primary }
    in
    tableFoot []
        [ tableRow False
            []
            [ tableCellHead [ colspan 3, class "has-text-right" ]
                [ button modifiers [ href <| toPath <| AddPlayerFormPage eventId tableId ] [ text "New" ]
                ]
            ]
        ]


renderPlayers : Players -> List (Html Msg)
renderPlayers players =
    List.map renderPlayer players


renderPlayer : Player -> Html Msg
renderPlayer player =
    tableRow False
        []
        [ tableCell [] [ text player.name ]
        , tableCell [] [ text <| Maybe.withDefault "" player.phone ]
        ]
