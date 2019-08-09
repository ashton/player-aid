module Events.TestFixtures exposing (eventFixture, eventListFixture)


eventFixture : String
eventFixture =
    """
      {
        "id": "5d3f1edfb264a30004b8ce38",
        "name": "NDJ",
        "date": "25/07/2019",
        "description": "Edição de 27/07/2019 da Noite de Jogos"
      }
    """


eventListFixture : String
eventListFixture =
    """
    [
      {
        "id": "a",
        "name": "a",
        "date": "a",
        "description": "a"
      },
      {
        "id": "b",
        "name": "b",
        "date": "b",
        "description": "b"
      }
    ]
    """
