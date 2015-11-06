import Test.Hspec
import Test.QuickCheck
import Text.Regex.Posix
import Urban

main :: IO ()
main = hspec $ do
  describe "Urban.getDefinition" $ do
    it "works" $ do
      fooDef <- getDefinition "foo"
      let s = fooDef =~ "term used for unimportant variables in programming" :: (String)
      s `shouldSatisfy` (/= "")
