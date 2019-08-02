module Events.Update exposing (init, update, updateEvents)

import Events.Data exposing (createEvent, getEvents)
import Events.Helpers exposing (updateFormDate, updateFormDescription, updateFormName)
import Events.Types exposing (Model, Msg(..))
import RemoteData exposing (RemoteData(..))
import Return exposing (Return, return)
import Types


init : Types.Config -> Return Msg Model
init config =
    let
        model =
            { events = Loading
            , form =
                { name = Nothing
                , date = Nothing
                , description = Nothing
                }
            }

        command =
            getEvents config.apiUrl
    in
    return model command


update : Types.Config -> Types.Msg -> Model -> Return Msg Model
update config msgFor model =
    case msgFor of
        Types.MsgForEvents msg ->
            updateEvents config msg model

        _ ->
            return model Cmd.none


updateEvents : Types.Config -> Msg -> Model -> Return Msg Model
updateEvents config msg model =
    case msg of
        HandleList events ->
            return { model | events = events } Cmd.none

        UpdateFormName name ->
            let
                updated =
                    updateFormName (Just name) model.form
            in
            return { model | form = updated } Cmd.none

        UpdateFormDate date ->
            let
                updated =
                    updateFormDate (Just date) model.form
            in
            return { model | form = updated } Cmd.none

        UpdateFormDescription description ->
            let
                updated =
                    updateFormDescription (Just description) model.form
            in
            return { model | form = updated } Cmd.none

        HandleFormSubmit ->
            return model (createEvent config.apiUrl model.form)

        EventCreated result ->
            case result of
                Success event ->
                    let
                        events =
                            RemoteData.map (\xs -> event :: xs) model.events
                    in
                    return { model | events = events } Cmd.none

                _ ->
                    return model Cmd.none
