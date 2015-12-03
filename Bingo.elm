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

initialModel = 
  {
    entries = [
      (newEntry "Future-Proof" 100 1),
      (newEntry "Doing Agile"  200 2),
      (newEntry "In The Cloud" 300 3),
      (newEntry "Cyber Attack" 400 4)
    ]
  }

-- UPDATE

type Action
  = NoOp
  | Sort

update action model =
  case action of
    NoOp ->
      model

-- VIEW

title message =
  message
    |> text

pageHeader =
  h1 [] [ title "Buzzword Bingo" ]


entryItem entry =
  li [] [ 
    div [] [ span [] [text entry.phrase] ],
    div [] [ span [] [text (toString entry.points)] ]
  ]

entryList =
  ul [ class "buzzword-list" ] (List.map entryItem initialModel.entries)


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
  view (update NoOp initialModel)