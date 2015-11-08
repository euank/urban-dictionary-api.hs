{-# LANGUAGE DeriveGeneric #-}

module Urban
    ( getDefinition
    , Definition(word,author,permalink,definition,example)
    ) where

import Network.HTTP.Client
import Network.HTTP.Types.Status (statusCode)
import Data.Aeson
import Data.ByteString.Char8 as BS
import Data.String
import Data.ByteString.Lazy as LBS
import GHC.Generics

data Definition = Definition {
    defid :: Int
  , word :: String
  , author :: String
  , permalink :: String
  , definition :: String
  , example :: String
  , thumbs_up :: Int
  , thumbs_down :: Int
  } deriving (Generic, Show)

instance FromJSON Definition
  -- Magic (see LANGUAGE DeriveGeneric)

data SearchResult = SearchResult {
    tags :: [String]
  , result_type :: String
  , list :: [Definition]
  } deriving (Generic, Show)

instance FromJSON SearchResult
  -- Magic (see LANGUAGE DeriveGeneric)


getDefinition :: String -> IO (Maybe Definition)
getDefinition word = do
  manager <- newManager defaultManagerSettings
  requestUrl <- parseUrl "http://api.urbandictionary.com/v0/define"
  let searchUrl = setQueryString [(BS.pack "page", Just $ BS.pack $ show 1), (BS.pack "term", Just $ BS.pack word)] requestUrl
  response <- httpLbs searchUrl manager

  let respBody = responseBody response
  let searchResult = decode respBody :: Maybe SearchResult

  return $ case fmap (result_type) searchResult of
    Just "exact" -> fmap (Prelude.head . list) searchResult
    _ -> Nothing
