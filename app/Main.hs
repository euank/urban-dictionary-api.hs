module Main where

import Urban

main :: IO ()
main = do
  def <- getDefinition "haskell"
  print def
