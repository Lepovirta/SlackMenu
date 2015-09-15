{-# LANGUAGE OverloadedStrings #-}
module SlackMenu.Config (readConfig) where

import SlackMenu.Types
import qualified Data.Configurator as C

-- Read config file.
readConfig :: FilePath -> IO Conf
readConfig cfgFile = do
  cfg  <- C.load [C.Required cfgFile]
  url  <- C.require cfg "url"
  name <- C.require cfg "name"
  icon <- C.require cfg "icon"
  return (Conf url name icon)
