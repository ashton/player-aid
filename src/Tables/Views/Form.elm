module Tables.Views.Form exposing (view)

import Bulma.Elements exposing (buttonModifiers)
import Bulma.Form exposing (controlButton, controlHelp, controlInput, controlInputModifiers, controlLabel, field)
import Bulma.Layout exposing (container)
import Bulma.Modifiers exposing (Color(..))
import Html exposing (Html, text)
import Html.Attributes as Attr
import Html.Events exposing (onClick, onInput)
import Maybe exposing (withDefault)
import Tables.Types exposing (Msg(..), TableData)


view : String -> TableData -> Html Msg
view eventId formData =
    let
        getString =
            withDefault ""

        class =
            Attr.class

        href =
            Attr.href

        value =
            getString >> Attr.value

        maxPlayers =
            Maybe.map String.fromInt formData.maxPlayers
    in
    container []
        [ field []
            [ controlLabel [] [ text "Game" ]
            , controlInput controlInputModifiers [] [ onInput UpdateFormGame, value formData.game ] []
            ]
        , field []
            [ controlLabel [] [ text "Max Players" ]
            , controlInput controlInputModifiers [] [ onInput UpdateFormMaxPlayers, value maxPlayers ] []
            ]
        , field []
            [ controlButton { buttonModifiers | color = Primary }
                [ class "has-text-right" ]
                [ href " ", onClick <| HandleFormSubmit eventId ]
                [ text "Create" ]
            ]
        ]
