module Feedback.Types exposing (Model)

import Bulma.Modifiers exposing (Color(..))


type alias Model =
    { text : Maybe String
    , color : Color
    }
