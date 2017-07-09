module PhotoGroove exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)

view model =
  div [ class "content" ]
      [ h1 [] [ text "Photo Groove" ]
      , div [ id "thumbnails" ]
        [ img [ src "img/thumb-1.jpg" ] []
        , img [ src "img/thumb-2.jpg" ] []
        , img [ src "img/thumb-3.jpg" ] []
        ]
      ]

main = 
  view "no model yet"
