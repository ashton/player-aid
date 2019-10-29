module Players.Views.Form exposing (view)

import Bulma.Elements exposing (buttonModifiers)
import Bulma.Form exposing (controlButton, controlHelp, controlInput, controlInputModifiers, controlLabel, field)
import Bulma.Layout exposing (container)
import Bulma.Modifiers exposing (Color(..))
import Html exposing (Html, text)
import Html.Attributes as Attr
import Html.Events exposing (onClick, onInput)
import Maybe exposing (withDefault)
import Players.Types exposing (Msg(..), PlayerData)


view : String -> String -> PlayerData -> Html Msg
view eventId tableId formData =
    let
        getString =
            withDefault ""

        class =
            Attr.class

        href =
            Attr.href

        value =
            getString >> Attr.value
    in
    container []
        [ field []
            [ controlLabel [] [ text "Name" ]
            , controlInput controlInputModifiers [] [ onInput UpdateFormName, value formData.name ] []
            ]
        , field []
            [ controlLabel [] [ text "Phone" ]
            , controlInput controlInputModifiers [] [ onInput UpdateFormPhone, value formData.phone ] []
            ]
        , field []
            [ controlButton { buttonModifiers | color = Primary }
                [ class "has-text-right" ]
                [ href " ", onClick <| HandleFormSubmit eventId tableId ]
                [ text "Register" ]
            ]
        ]
