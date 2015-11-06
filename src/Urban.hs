module Urban
    ( getDefinition
    ) where

import Network.HTTP.Client
import Network.HTTP.Types.Status (statusCode)
import Data.Aeson (object, (.=), encode)
import Data.ByteString.Char8 as BS
import Data.ByteString.Lazy as LBS

getDefinition word = do
  manager <- newManager defaultManagerSettings
  requestUrl <- parseUrl "http://api.urbandictionary.com/v0/define"
  let searchUrl = setQueryString [(BS.pack "page", Just $ BS.pack $ show 1), (BS.pack "term", Just $ BS.pack word)] requestUrl
  response <- httpLbs searchUrl manager

  -- TODO, parse json
  -- TODO, extract just the exact match / word

  return $ show $ responseBody response
