module Bingo where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import String exposing (toUpper, repeat, trimRight)
import Signal exposing (Address)
import StartApp.Simple as StartApp


-- MODEL

type alias Entry =
  { 
    phrase: String, 
    points: Int, 
    wasSpoken: Bool, 
    id: Int 
  }


type alias Model =
  {
    entries: List Entry
  }


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


update : Action -> Model -> Model
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


title : String -> Html
title message =
  message
    |> text


pageHeader : Html
pageHeader =
  h1 [] [ title "Buzzword Bingo" ]


totalPoints : List Entry -> Int
totalPoints entries =
  let
    spokenEntries = List.filter .wasSpoken entries
  in
    List.sum (List.map .points spokenEntries)


totalItem : Int -> Html
totalItem points =
  ul [ class "points" ]
  [
    li [] [ text "Points" ],
    li [] [ text (toString points) ]
  ]


entryItem : Address Action -> Entry -> Html
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
          [ class "delete", onClick address (Delete entry.id) ] 
          [ text "×" ]
      ]
    ]


entryList : Address Action -> List Entry -> Html
entryList address entries =
  let
    entryItems = (List.map (entryItem address) entries)
  in
    ul 
      [ class "buzzword-list" ] entryItems
      

pageFooter : Html
pageFooter =
  footer [ ]
    [
      a [href "http://github.com/jshor" ] [ text "@jshor" ]
    ]


view : Address Action -> Model -> Html
view address model = 
  div [ class "view" ] [ 
    pageHeader, 
    (entryList address model.entries),
    button 
      [ class "sort", onClick address Sort ]
      [ text "Sort" ],
    ( totalItem (totalPoints model.entries) ),
    pageFooter 
  ]


main : Signal Html
main =
  StartApp.start
    {
      model = initialModel,
      view = view,
      update = update
    }