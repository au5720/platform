module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)



-- MAIN


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- MODEL


type alias Model =
    { gamesList : List Game
    , displayGameList : Bool
    }


type alias Game =
    { title : String
    , description : String
    }


initialModel : Model
initialModel =
    { gamesList =
        [ { title = "Platform Game", description = "Platform game example" }
        , { title = "AdventureGame", description = "Adventure game example" }
        ]
    , displayGameList = True
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( initialModel, Cmd.none )



-- UPDATE


type Msg
    = DisplayGameList
    | HideGameList


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DisplayGameList ->
            ( { model | displayGameList = True }, Cmd.none )

        HideGameList ->
            ( { model | displayGameList = False }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h1 [ class "games-section" ] [ text "Games" ]
        , button [ class "button", onClick DisplayGameList ] [ text "Display Games List" ]
        , button [ class "button", onClick HideGameList ] [ text "Hide Games List" ]
        , if model.displayGameList then
            gameIndex model

          else
            div [] []
        ]


gameIndex : Model -> Html msg
gameIndex model =
    div [ class "games-index" ] [ gameList model.gamesList ]


gameList : List Game -> Html msg
gameList games =
    ul [ class "games-list" ] (List.map gameListItem games)


gameListItem : Game -> Html msg
gameListItem game =
    li []
        [ strong [] [ text game.title ]
        , p [] [ text game.description ]
        ]
