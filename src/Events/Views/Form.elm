module Events.Views.Form exposing (view)

import Bulma.Elements exposing (buttonModifiers)
import Bulma.Form exposing (controlButton, controlHelp, controlInput, controlInputModifiers, controlLabel, controlTextArea, controlTextAreaModifiers, field)
import Bulma.Layout exposing (container)
import Bulma.Modifiers exposing (Color(..))
import Events.Types exposing (EventData, Msg(..))
import Html exposing (Html, text)
import Html.Attributes as Attr
import Html.Events exposing (onClick, onInput)
import Maybe exposing (withDefault)


view : EventData -> Html Msg
view model =
    let
        getString =
            withDefault ""

        value =
            getString >> Attr.value

        class =
            Attr.class

        href =
            Attr.href
    in
    container []
        [ field []
            [ controlLabel [] [ text "Name" ]
            , controlInput controlInputModifiers [] [ onInput UpdateFormName, value model.name ] []
            , controlHelp Default [] []
            ]
        , field []
            [ controlLabel [] [ text "Date" ]
            , controlInput controlInputModifiers [] [ onInput UpdateFormDate, value model.date ] []
            , controlHelp Default [] []
            ]
        , field []
            [ controlLabel [] [ text "Description" ]
            , controlTextArea controlTextAreaModifiers [] [ onInput UpdateFormDescription, value model.description ] []
            , controlHelp Default [] []
            ]
        , field []
            [ controlButton { buttonModifiers | color = Primary }
                [ class "has-text-right" ]
                [ href " ", onClick HandleFormSubmit ]
                [ text "Create" ]
            ]
        ]
