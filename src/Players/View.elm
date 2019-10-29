module Players.View exposing (listView)

import Html exposing (Html)
import Players.Types exposing (Model, Msg(..))
import Players.Views.List as ListView


listView : String -> String -> Model -> Html Msg
listView eventId tableId model =
    ListView.view model
