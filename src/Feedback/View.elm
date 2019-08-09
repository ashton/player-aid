module Feedback.View exposing (view)

import Bulma.Elements exposing (easyDelete, notification)
import Feedback.Types exposing (Model, Msg(..))
import Html exposing (Html, div, text)
import Html.Attributes exposing (href)


view : Model -> Html Msg
view model =
    case model.text of
        Just message ->
            notification model.color
                []
                [ text message
                , easyDelete [ href " " ] ClearFeedback
                ]

        Nothing ->
            div [] []
