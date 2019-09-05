module Tables.Views.Form exposing (view)

import Bulma.Form exposing (controlButton, controlHelp, controlInput, controlInputModifiers, controlLabel, field)
import Bulma.Layout exposing (container)
import Html exposing (Html, text)
import Html.Attributes as Attr
import Html.Events exposing (onClick, onInput)
import Maybe exposing (withDefault)
import Tables.Types exposing (Msg(..), TableData)


view : TableData -> Html Msg
view formData =
    let
        getString =
            withDefault ""

        value =
            getString >> Attr.value
    in
    container []
        [ field []
            [ controlLabel [] [ text "Game" ]
            , controlInput controlInputModifiers [] [ onInput UpdateFormGame, value formData.game ] []
            ],
            field [] [
              controlLabel [] [ text "Max Players" ],
              , controlInput controlInputModifiers [] [ onInput UpdateFormMaxPlayers, value formData.maxPlayers ]
              ]
        ]
