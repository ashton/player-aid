module Players.View exposing (formView, listView)

import Html exposing (Html)
import Players.Types exposing (Model, Msg(..))
import Players.Views.Form as FormView
import Players.Views.List as ListView


listView : String -> String -> Model -> Html Msg
listView eventId tableId model =
    ListView.view eventId tableId model.players


formView : String -> String -> Model -> Html Msg
formView eventId tableId model =
    FormView.view eventId tableId model.form
