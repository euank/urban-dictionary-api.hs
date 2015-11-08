module Main where

import Urban

main :: IO ()
main = do
  print . getDefinition $ "haskell"
