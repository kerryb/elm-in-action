module PhotoGroove exposing (..)
import Array exposing (get, fromList)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Random

type Message = Select String
             | Surprise
             | ChangeThumbnailSize ThumbnailSize

type ThumbnailSize = Small
                   | Medium
                   | Large

type alias Photo = { url : String }

type alias Model = { photos : List Photo
                   , selectedUrl : String
                   , thumbnailSize : ThumbnailSize
                   }

view : Model -> Html Message
view model =
  div [ class "content" ]
      [ h1 [] [ text "Photo Groove" ]
      , button [ onClick Surprise ] [ text "Surprise me!" ]
      , h3 [] [text "Thumbnail size" ]
      , div [ id "choose-size" ]
            (List.map (viewSizeChooser model.thumbnailSize) [ Small, Medium, Large ])
      , div [ id "thumbnails", class (thumbnailSizeClass model.thumbnailSize) ]
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

viewSizeChooser : ThumbnailSize -> ThumbnailSize -> Html Message
viewSizeChooser currentSize size =
  label []
        [ input [ type_ "radio", name "size"
                , checked (size == currentSize)
                , onClick (ChangeThumbnailSize size)
        ] []
        , text (sizeToString size)
        , text " "
        ]

sizeToString : ThumbnailSize -> String
sizeToString size =
  case size of
    Small -> "S"
    Medium -> "M"
    Large -> "L"

thumbnailSizeClass : ThumbnailSize -> String
thumbnailSizeClass size =
  case size of
    Small -> "small"
    Medium -> "med"
    Large -> "large"

initialModel : Model
initialModel =
  { photos =
    [ { url = "1.jpg" }
    , { url = "2.jpg" }
    , { url = "3.jpg" }
    ]
    , selectedUrl = "1.jpg"
    , thumbnailSize = Medium
  }

photos : Array.Array Photo
photos = Array.fromList initialModel.photos

getPhotoUrl : Int -> String
getPhotoUrl index =
  case Array.get index photos of
    Just photo -> photo.url
    Nothing -> ""

randomPhotoPicker : Random.Generator Int
randomPhotoPicker = Random.int 0 (Array.length photos - 1)

update : Message -> Model -> Model
update message model =
  case message of
    Select url ->
      { model | selectedUrl = url }
    Surprise ->
      { model | selectedUrl = "2.jpg" }
    ChangeThumbnailSize size ->
      { model | thumbnailSize = size }

main =
  Html.beginnerProgram
  { model = initialModel
  , view = view
  , update = update
  }
