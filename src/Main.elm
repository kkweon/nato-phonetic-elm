module Main exposing (..)

import NatoPhonetic exposing (natoPhonetic)
import String
import List
import Char
import Maybe
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Dict exposing (get)


-- Character to Nato Words


char2Nato : Char -> Maybe String
char2Nato x =
    let
        buildString x y =
            toString x ++ " -> " ++ y

        getter x =
            get x natoPhonetic
                |> Maybe.map (buildString x)
    in
        x
            |> Char.toUpper
            |> getter


sentence2Nato : String -> List (Maybe String)
sentence2Nato xs =
    String.toList xs
        |> List.map char2Nato



-- List (Maybe String) -> List String


concatListMaybeString : List (Maybe String) -> String
concatListMaybeString xs =
    let
        handleMaybe : Maybe String -> String
        handleMaybe xs =
            case xs of
                Nothing ->
                    ""

                Just val ->
                    val
    in
        xs
            |> List.map handleMaybe
            |> String.join "\n"



-- Model


type alias Model =
    { input : String }


initModel : Model
initModel =
    { input = ""
    }



-- Update


type Msg
    = Convert String
    | ClearInputBox


update : Msg -> Model -> Model
update msg model =
    case msg of
        Convert sentence ->
            { model
                | input = sentence
            }

        ClearInputBox ->
            { model | input = "" }



-- View


view : Model -> Html Msg
view model =
    let
        title =
            h1 [ class "title" ] [ text "Nato Phonetic Word Converter" ]

        description =
            p [ class "description" ] [ text "Type any sentence and it will be converted to Nato Phonetic Words." ]

        searchIcon =
            i [ class "ion-ios-search icon search-icon" ] []

        clearIcon =
            if String.isEmpty model.input then
                text ""
            else
                i
                    [ class "ion-ios-close-empty icon clear-icon"
                    , onClick ClearInputBox
                    ]
                    []

        inputBox =
            input
                [ placeholder "Type a sentence"
                , onInput Convert
                , class "placeholder-view"
                , value model.input
                ]
                []

        inputArea =
            div [ class "input-area" ]
                [ inputBox
                , searchIcon
                , clearIcon
                ]
    in
        div [ class "main-view" ]
            [ title
            , description
            , inputArea
            , br [] []
            , p [ class "result-view" ] [ viewPhonetic model.input ]
            ]


viewPhonetic : String -> Html Msg
viewPhonetic input =
    input
        |> sentence2Nato
        |> concatListMaybeString
        |> text


main : Program Never Model Msg
main =
    beginnerProgram
        { model = initModel
        , view = view
        , update = update
        }
