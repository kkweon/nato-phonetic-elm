module Main exposing (..)

import NatoPhonetic exposing (natoPhonetic)
import String
import List
import Char
import Maybe
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Dict exposing (..)


-- Character to Nato Words


char2Nato : Char -> Maybe String
char2Nato x =
    let
        getter x =
            Maybe.map
                (\r -> (String.cons x " -> ") ++ r)
                (get x natoPhonetic)
    in
        x
            |> Char.toUpper
            |> getter


sentence2Nato : String -> List (Maybe String)
sentence2Nato xs =
    List.map char2Nato (String.toList xs)



-- List (Maybe String) -> List String


concatListMaybeString : List (Maybe String) -> String
concatListMaybeString xs =
    xs
        |> List.filter
            (\x ->
                case x of
                    Nothing ->
                        False

                    _ ->
                        True
            )
        |> List.map
            (\x ->
                case x of
                    Just x ->
                        x

                    Nothing ->
                        ""
            )
        |> String.join "\x0D\n"



-- Model


type alias Model =
    { target : String }


initModel : Model
initModel =
    Model ""



-- Update


type Msg
    = Convert String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Convert sentence ->
            { model
                | target =
                    sentence
                        |> sentence2Nato
                        |> concatListMaybeString
            }



-- View


mainStyle : Attribute msg
mainStyle =
    style
        [ ( "width", "50%" )
        , ( "margin", "auto" )
        ]


placeholderStyle : Attribute msg
placeholderStyle =
    style
        [ ( "width", "100%" )
        , ( "height", "10%" )
        , ( "font-size", "2em" )
        ]


outputStyle : Attribute msg
outputStyle =
    style
        [ ( "font-size", "2em" )
        , ( "line-height", "1.5" )
        , ( "white-space", "pre-line" )
        ]


view : Model -> Html Msg
view model =
    div [ mainStyle ]
        [ input [ placeholder "type sentence", onInput Convert, placeholderStyle ] []
        , br [] []
        , p [ outputStyle ] [ text model.target ]
        ]


main : Program Never Model Msg
main =
    beginnerProgram
        { model = initModel
        , view = view
        , update = update
        }
