module PhotoGroove exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

type Message = Select String
             | Surprise

type alias Photo = { url : String }
type alias Model = { photos : List Photo, selectedUrl : String }

view : Model -> Html Message
view model =
  div [ class "content" ]
      [ h1 [] [ text "Photo Groove" ]
      , button [ onClick Surprise ] [ text "Surprise me!" ]
      , div [ id "thumbnails" ]
            (List.map (viewThumbnail model.selectedUrl) model.photos)
      , img [ src ("img/full/" ++ model.selectedUrl)
            , class "large"
            ]
            []
      ]

viewThumbnail : String -> Photo -> Html Message
viewThumbnail selectedUrl photo =
    img [ src ("img/thumb/" ++ photo.url)
          , classList [ ( "selected", selectedUrl == photo.url ) ]
          , onClick (Select photo.url)
          ]
          []

initialModel : Model
initialModel =
  { photos =
    [ { url = "1.jpg" }
    , { url = "2.jpg" }
    , { url = "3.jpg" }
    ]
    , selectedUrl = "1.jpg"
  }

update : Message -> Model -> Model
update message model =
  case message of
    Select url ->
      { model | selectedUrl = url }
    Surprise ->
      { model | selectedUrl = "2.jpg" }

main =
  Html.beginnerProgram
  { model = initialModel
  , view = view
  , update = update
  }
