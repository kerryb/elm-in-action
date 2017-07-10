module PhotoGroove exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

view model =
  div [ class "content" ]
      [ h1 [] [ text "Photo Groove" ]
      , div [ id "thumbnails" ]
            (List.map (viewThumbnail model.selectedUrl) model.photos)
      , img [ src ("img/full/" ++ model.selectedUrl)
            , class "large"
            ]
            []
      ]

viewThumbnail selectedUrl photo =
    img [ src ("img/thumb/" ++ photo.url)
          , classList [ ( "selected", selectedUrl == photo.url ) ]
          , onClick (Select photo.url)
          ]
          []

initialModel =
  { photos =
    [ { url = "1.jpg" }
    , { url = "2.jpg" }
    , { url = "3.jpg" }
    ]
    , selectedUrl = "1.jpg"
  }

type Message =
  Select String

update message model =
  case message of
    Select url ->
      { model | selectedUrl = url }

main =
  Html.beginnerProgram
  { model = initialModel
  , view = view
  , update = update
  }
