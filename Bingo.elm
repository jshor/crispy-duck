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
  | Delete Int
  | Mark Int


update action model =
  case action of
    NoOp ->
      model
    
    Sort ->
      { model | entries = List.sortBy .points model.entries}

    Delete id ->
      let remainingEntries = 
        List.filter (\e -> e.id /= id) model.entries
      in
        { model | entries = remainingEntries }

    Mark id ->
      let
        updatedEntry e =
          if e.id == id then { e | wasSpoken = (not e.wasSpoken) } else e
      in
        { model | entries = List.map updatedEntry model.entries }
-- VIEW


title message =
  message
    |> text


pageHeader =
  h1 [] [ title "Buzzword Bingo" ]


totalPoints entries =
  let
    spokenEntries = List.filter .wasSpoken entries
  in
    List.sum (List.map .points spokenEntries)


totalItem points =
  ul [ class "points" ]
  [
    li [] [ text "Points" ],
    li [] [ text (toString points) ]
  ]


entryItem address entry =
  li 
    [
      classList [ ("highlight", entry.wasSpoken) ],
      onClick address (Mark entry.id)
    ] 
    [ 
      div [] [ span [] [text entry.phrase] ],
      div [] [ 
        span [] [ text (toString entry.points) ],
        span 
          [ onClick address (Delete entry.id) ] 
          [ text "×" ]
      ]
    ]


entryList address entries =
  let
    items = [ totalItem (totalPoints entries) ]
  in
    ul 
      [ class "buzzword-list" ]
      (List.map (entryItem address) entries)


pageFooter =
  footer [ ]
    [
      a [href "http://example.com" ] [ text "Hello, world" ]
    ]


view address model = 
  div [ class "view" ] [ 
    pageHeader, 
    (entryList address model.entries),
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