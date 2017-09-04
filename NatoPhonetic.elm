module NatoPhonetic exposing (natoPhonetic)

import Dict

natoPhonetic : Dict.Dict Char String
natoPhonetic =
    Dict.fromList
        [ ( 'A', "Alf" )
        , ( 'B', "Bravo" )
        , ( 'C', "Charlie" )
        , ( 'D', "Delta" )
        , ( 'E', "Echo" )
        , ( 'F', "Foxtrot" )
        , ( 'G', "Golf" )
        , ( 'H', "Hotel" )
        , ( 'I', "India" )
        , ( 'J', "Juliet" )
        , ( 'K', "Kilo" )
        , ( 'L', "Lima" )
        , ( 'M', "Mike" )
        , ( 'N', "November" )
        , ( 'O', "Oscar" )
        , ( 'P', "Papa" )
        , ( 'Q', "Quebec" )
        , ( 'R', "Romeo" )
        , ( 'S', "Sierra" )
        , ( 'T', "Tango" )
        , ( 'U', "Uniform" )
        , ( 'V', "Victor" )
        , ( 'W', "Whiskey" )
        , ( 'X', "X" )
        , ( 'Y', "Yankee" )
        , ( 'Z', "Zulu" )
        , ( '-', "Dash" )
        ]
