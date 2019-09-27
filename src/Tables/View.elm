module Tables.View exposing (formView, listView)

import Html exposing (Html)
import Tables.Types exposing (Model, Msg(..))
import Tables.Views.Form as FormView
import Tables.Views.List as ListView


formView : String -> Model -> Html Msg
formView eventId model =
    FormView.view eventId model.form


listView : String -> Model -> Html Msg
listView eventId model =
    ListView.view eventId model.tables
