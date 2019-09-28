module Feedback.Types exposing (Model, Msg(..), Notification)

import Bulma.Modifiers exposing (Color(..))


type alias Notification =
    Maybe
        { text : String
        , color : Color
        }


type alias Model =
    { text : Maybe String
    , color : Color
    }


type Msg
    = ClearFeedback
