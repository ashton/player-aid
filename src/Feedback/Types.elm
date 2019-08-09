module Feedback.Types exposing (Model, Msg(..))

import Bulma.Modifiers exposing (Color(..))


type alias Model =
    { text : Maybe String
    , color : Color
    }


type Msg
    = ClearFeedback
