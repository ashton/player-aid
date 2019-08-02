module Events.View exposing (formView, listView)

import Events.Types exposing (Model, Msg(..))
import Events.Views.Form as FormView
import Events.Views.List as ListView
import Html exposing (Html)


listView : Model -> Html Msg
listView model =
    ListView.view model


formView : Model -> Html Msg
formView model =
    FormView.view model.form
