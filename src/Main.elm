module Main exposing (..)

import Browser
import NatoPhonetic exposing (natoPhonetic)
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Dict exposing (get)
import Char
import Json.Decode as Decode


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



-- View Helpers


onEscape : Msg -> Attribute Msg
onEscape msg =
    let
        isEscape key =
            if key == "Escape" then
                Decode.succeed msg
            else
                Decode.fail "not escape"
    in
    on "keydown" (Decode.field "key" Decode.string |> Decode.andThen isEscape)



-- View


view : Model -> Html Msg
view model =
    let
        charCount =
            String.length model.input

        inputSection =
            section [ class "bg-white rounded-xl p-6 shadow-sm border border-primary/5" ]
                [ div [ class "flex flex-col gap-2" ]
                    [ label [ class "text-sm font-bold uppercase tracking-wider text-slate-500", attribute "for" "input-text" ]
                        [ text "Input Text" ]
                    , p [ class "text-slate-500 text-sm mb-2" ]
                        [ text "Type names or phrases below to see the phonetic conversion in real-time." ]
                    , div [ class "relative" ]
                        [ input
                            [ class "w-full rounded-xl border-2 border-slate-200 focus:border-primary focus:ring-0 p-4 pr-12 text-xl font-medium placeholder:text-slate-300 transition-all"
                            , attribute "id" "input-text"
                            , placeholder "Enter name or text here (e.g. HELLO)..."
                            , onInput Convert
                            , onEscape ClearInputBox
                            , value model.input
                            , autofocus True
                            ]
                            []
                        , if not (String.isEmpty model.input) then
                            button
                                [ type_ "button"
                                , class "absolute top-1/2 -translate-y-1/2 right-3 p-2 text-slate-400 hover:text-slate-600 hover:bg-slate-100 rounded-lg transition-colors text-2xl font-light cursor-pointer"
                                , onClick ClearInputBox
                                , attribute "title" "Clear"
                                ]
                                [ text "×" ]
                          else
                            text ""
                        ]
                    ]
                ]

        resultsHeader =
            div [ class "flex items-center justify-between px-2 flex-wrap gap-y-2" ]
                [ h3 [ class "text-xl font-bold text-[#0e101b]" ] [ text "Conversion Result" ]
                , span [ class "text-sm font-medium text-primary bg-primary/10 px-3 py-1 rounded-full" ]
                    [ text (String.fromInt charCount ++ " Character" ++ (if charCount == 1 then "" else "s")) ]
                ]

        resultsSection =
            section [ class "space-y-4" ]
                [ resultsHeader
                , viewPhonetic model.input
                ]
    in
        div [ class "relative flex h-auto min-h-screen w-full flex-col overflow-x-hidden" ]
            [ Html.node "main" [ class "flex-1 flex flex-col px-6 py-8 lg:px-20 gap-8 items-center" ]
                [ div [ class "max-w-4xl space-y-8 w-full" ]
                    [ h1 [ class "text-4xl font-black text-[#0e101b] text-center mb-2" ]
                        [ text "NATO Phonetic Alphabet Converter" ]
                    , p [ class "text-center text-slate-600 mb-6" ]
                        [ text "Convert text to phonetic alphabet for clear communication" ]
                    , inputSection
                    , resultsSection
                    ]
                ]
            ]


viewPhonetic : String -> Html Msg
viewPhonetic sentence =
    sentence
        |> String.trim
        |> String.toList
        |> List.map char2Nato
        |> List.map viewCard
        |> div [ class "phonetic-grid" ]


char2Nato : Char -> ( Char, Maybe String )
char2Nato x =
    let
        phoneticWord =
            x
                |> Char.toUpper
                |> \c -> get c natoPhonetic
    in
        ( x, phoneticWord )


viewCard : ( Char, Maybe String ) -> Html Msg
viewCard ( char, phoneticWord ) =
    if char == ' ' then
        viewSpaceCard
    else
        case phoneticWord of
            Just word ->
                viewLetterCard (Char.toUpper char) word

            Nothing ->
                text ""


viewLetterCard : Char -> String -> Html Msg
viewLetterCard char word =
    div [ class "bg-white border-2 border-slate-100 rounded-xl p-5 flex flex-col items-center justify-center gap-1 shadow-sm hover:border-primary/30 transition-colors group" ]
        [ span [ class "text-slate-400 text-2xl font-bold group-hover:text-primary transition-colors" ]
            [ text (String.fromChar char) ]
        , span [ class "text-3xl font-black text-[#0e101b] tracking-tight" ]
            [ text (String.toUpper word) ]
        ]


viewSpaceCard : Html Msg
viewSpaceCard =
    div [ class "bg-slate-50 border-2 border-dashed border-slate-200 rounded-xl p-5 flex flex-col items-center justify-center gap-1 shadow-sm" ]
        [ span [ class "text-slate-400 text-sm font-bold" ]
            [ text "[SPACE]" ]
        , span [ class "text-xl font-bold text-slate-400 uppercase tracking-widest" ]
            [ text "SPACE" ]
        ]
