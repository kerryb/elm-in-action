module PhotoGroove exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)

view model =
  div [ class "content" ]
      [ h1 [] [ text "Photo Groove" ]
      , div [ id "thumbnails" ] (List.map viewThumbnail model)
      ]

viewThumbnail thumbnail = 
  img [ src ("img/thumb/" ++ thumbnail.url) ] []

initialModel = 
  [ { url = "1.jpg" }
  , { url = "2.jpg" }
  , { url = "3.jpg" }
  ]

main = 
  view initialModel
