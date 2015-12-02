module Bingo where

import Html
import String

main = 
  Html.text (String.repeat 4 (String.toUpper "bingo! "))