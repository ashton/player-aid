module Tables.Update exposing (init, update, updateTables)

import Return exposing (Return, return)
import Tables.Helpers exposing (updateFormGame)
import Tables.Types exposing (Model, Msg(..), TableData)
import Types


init : Return Msg Model
init =
    return
        { form =
            { game = Nothing
            , maxPlayers = Nothing
            , event = Nothing
            }
        }
        Cmd.none


update : Types.Msg -> Model -> Return Msg Model
update msgFor model =
    case msgFor of
        Types.MsgForTables msg ->
            updateTables msg model

        _ ->
            return model Cmd.none


updateTables : Msg -> Model -> Return Msg Model
updateTables msg model =
    case msg of
        UpdateFormGame game ->
            let
                updatedForm =
                    updateFormGame (Just game) model.form
            in
            return { model | form = updatedForm } Cmd.none
