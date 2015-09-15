{-# LANGUAGE OverloadedStrings #-}
module SlackMenu.Slack (menuToSlack) where

import SlackMenu.Types
import Control.Lens
import Data.Aeson
import Data.List (intersperse)
import Data.Text (Text)
import Network.Wreq
import qualified Data.Text as T

-- Format menus for chat.
formatMenus :: [Menu] -> [Text]
formatMenus ms =
    let format (t,d) = T.concat [t, ":\n", (T.replace ", " "\n" d)]
        wrap x = T.concat ["```\n",  x, "\n```"]
    in map (wrap . format) ms

-- Create payload from menus.
createPayload :: Conf -> [Menu] -> MyPayload
createPayload c ms =
    let msg = T.concat $ intersperse ("\n") $ formatMenus ms
    in MyPayload msg (cName c) (cIcon c)

-- Send menu to Slack channel.
menuToSlack :: Conf -> [Menu] -> IO (Int)
menuToSlack c ms = do
    let body = encode $ createPayload c ms
    r <- post (T.unpack $ cUrl c) body
    let code = r ^. responseStatus ^. statusCode
    return (code)
