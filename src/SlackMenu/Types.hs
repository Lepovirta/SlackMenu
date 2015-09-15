{-# LANGUAGE DeriveGeneric #-}
module SlackMenu.Types where

import GHC.Generics
import Data.Aeson
import Data.Text (Text)

type Menu = (Text,Text)

data Conf = Conf
  { cUrl  :: Text
  , cName :: Text
  , cIcon :: Text
  }

data MyPayload = MyPayload
  { text       :: Text
  , username   :: Text
  , icon_emoji :: Text
  } deriving (Show, Generic)

instance ToJSON MyPayload
