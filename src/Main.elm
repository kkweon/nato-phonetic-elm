module Main exposing (..)

import Browser
import NatoPhonetic exposing (natoPhonetic)
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Dict exposing (get)


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initModel
        , view = view
        , update = update
        }



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
            , viewPhonetic model.input
            ]


viewPhonetic : String -> Html Msg
viewPhonetic sentence =
    sentence
        |> sentence2Nato

char2Nato : Char -> ( Char, Maybe String )
char2Nato x =
    let
        phoneticWord =
            x
                |> Char.toUpper
                |> \c -> get c natoPhonetic
    in
        ( x, phoneticWord )


sentence2Nato : String -> Html Msg
sentence2Nato xs =
    xs
        |> String.toList
        |> List.map (char2Nato >> viewRow)
        |> table [class "result-view"]


viewRow : ( Char, Maybe String ) -> Html Msg
viewRow ( char, phoneticWord ) =
    let
        (word, arrow) =
            case phoneticWord of
                Just w ->
                    (w, "⟼")


                Nothing ->
                    ("", "")
    in
        tr []
            [ td [] [ text (String.fromChar (Char.toUpper char)) ]
            , td [] [ text arrow ]
            , td [] [ text word ]
            ]
