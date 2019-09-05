module Tables.View exposing (formView)

import Html exposing (Html)
import Tables.Types exposing (Model, Msg(..))
import Tables.Views.Form as FormView


formView : Model -> Html Msg
formView model =
    FormView.view model.form
