{-# LANGUAGE OverloadedStrings #-}
module Main where

import SonaattiMenu
import SlackMenu.Slack
import SlackMenu.Config

-- Find menus and print status code from HTTP response.
main :: IO ()
main = do
    conf <- readConfig "slack.cfg"
    print =<< menuToSlack conf =<< findMenus ["piato", "wilhelmiina"]
