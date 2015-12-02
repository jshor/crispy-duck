module Bingo where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import String exposing (toUpper, repeat, trimRight)


newEntry phrase points id =
  {
    phrase = phrase,
    points = points,
    id = id,
    wasSpoken = False
  }

title message =
  message
    |> toUpper
    |> text

pageHeader =
  h1 [] [ title "Buzzword Bingo" ]


entryItem entry =
  li [] [ text entry.phrase ]


entryList =
  ul [] [
    entryItem (newEntry "Future-Proof" 100 1),
    entryItem (newEntry "Doing Agile" 200 2)
  ]


pageFooter =
  footer [ ]
    [
      a [href "http://example.com" ] [ text "Josh's shitty elm code" ]
    ]

view = 
  div [ class "view" ] [ 
    pageHeader, 
    entryList, 
    pageFooter 
  ]

main =
  view