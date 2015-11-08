{-# LANGUAGE NamedFieldPuns #-}
import Test.Hspec
import Test.QuickCheck
import Text.Regex.Posix
import Urban

main :: IO ()
main = hspec $ do
  describe "Urban.getDefinition" $ do
    it "works" $ do
      fooDef <- getDefinition "foo"
      case fooDef of
        Just def -> do
          let s = (Urban.definition def) =~ "term used for unimportant variables in programming" :: (String)
          s `shouldSatisfy` (/= "")
        Nothing -> error "No result for foo"
