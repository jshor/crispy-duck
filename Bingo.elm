module Bingo where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import String exposing (toUpper, repeat, trimRight)
import StartApp.Simple as StartApp

-- MODEL

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
      (newEntry "Future-Proof" 300 3),
      (newEntry "Doing Agile"  200 2),
      (newEntry "In The Cloud" 400 4),
      (newEntry "Cyber Attack" 100 1)
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
    
    Sort ->
      { model | entries = List.sortBy .points model.entries}

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

entryList entries =
  ul [ class "buzzword-list" ] (List.map entryItem entries)

pageFooter =
  footer [ ]
    [
      a [href "http://example.com" ] [ text "Hello, world" ]
    ]

view address model = 
  div [ class "view" ] [ 
    pageHeader, 
    (entryList model.entries),
    button 
      [ class "sort", onClick address Sort ] 
      [ text "Sort" ],
    pageFooter 
  ]

main =
  StartApp.start
    {
      model = initialModel,
      view = view,
      update = update
    }