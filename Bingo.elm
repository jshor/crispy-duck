module Bingo where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import String exposing (toUpper, repeat, trimRight)


title message times =
  message ++ " "
    |> toUpper
    |> repeat times
    |> trimRight
    |> text

pageHeader =
  h1 [] [ title "Hello there!" 3 ]


pageFooter =
  footer [ ]
    [
      a [href "http://example.com" ] [ text "Josh's shitty elm code" ]
    ]

view = 
  div [ ] [ pageHeader, pageFooter ]

main =
  view