module Components.Atoms.Markdown exposing (doc, markdown, markdownUnsafe)

import ElmBook.Chapter exposing (Chapter, chapter, renderComponentList)
import Html exposing (Html)
import Html.Attributes exposing (class, classList)
import Markdown exposing (Options)


markdown : List String -> String -> Html msg
markdown classes md =
    render defaultOptions classes md


markdownUnsafe : List String -> String -> Html msg
markdownUnsafe classes md =
    render { defaultOptions | sanitize = False } classes md


render : Options -> List String -> String -> Html msg
render options classes md =
    Markdown.toHtmlWith options [ class "markdown", classList (classes |> List.map (\c -> ( c, True ))) ] md


defaultOptions : Options
defaultOptions =
    { githubFlavored = Just { tables = True, breaks = True }
    , defaultHighlighting = Nothing
    , sanitize = True
    , smartypants = True
    }



-- DOCUMENTATION


doc : Chapter x
doc =
    chapter "Markdown"
        |> renderComponentList
            [ ( "markdown", markdown [] "Some *text*, but <b>html</b> is escaped \\o/" )
            , ( "markdownUnsafe", markdownUnsafe [] "Some *text* with <b>html</b> working!" )
            ]