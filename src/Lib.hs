{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( exec
    ) where

import qualified Data.Text.IO    as TIO
import           GHC.Generics    (Generic)
import           Options.Generic
import           Text.Toml       (parseTomlDoc)

data Program = Program { file :: FilePath }
    deriving (Generic)

instance ParseRecord Program

exec :: IO ()
exec = do
    x <- getRecord "Command-line wrapper around htoml"
    let path = file x
    contents <- TIO.readFile path
    case parseTomlDoc path contents of
        Right{} -> pure ()
        Left e  -> print e
