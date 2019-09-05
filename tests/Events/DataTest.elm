module Events.DataTest exposing (suite)

import Events.Data exposing (eventDecoder, eventListDecoder)
import Events.TestFixtures exposing (eventFixture, eventListFixture)
import Expect
import Json.Decode exposing (decodeString)
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "Events module"
        [ describe "Events.Data"
            [ test "decodes event data" <|
                \_ ->
                    eventFixture
                        |> decodeString eventDecoder
                        |> Expect.equal
                            (Ok
                                { id = "5d3f1edfb264a30004b8ce38"
                                , name = "NDJ"
                                , date = "25/07/2019"
                                , description = "Edição de 27/07/2019 da Noite de Jogos"
                                }
                            )
            , test "decode event lists" <|
                \_ ->
                    eventListFixture
                        |> decodeString eventListDecoder
                        |> Expect.equal
                            (Ok
                                [ { id = "a"
                                  , name = "a"
                                  , date = "a"
                                  , description = "a"
                                  }
                                , { id = "b"
                                  , name = "b"
                                  , date = "b"
                                  , description = "b"
                                  }
                                ]
                            )
            ]
        ]
