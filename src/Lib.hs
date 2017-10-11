{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}

module Lib
    ( exec
    ) where

import qualified Data.Text.IO    as TIO
import           GHC.Generics    (Generic)
import           Options.Generic
import           Text.Megaparsec (parseErrorPretty)
import           Text.Toml       (parseTomlDoc)

newtype Program = Program { file :: FilePath <?> "Path to file to be checked." }
    deriving (Generic)

programModifiers :: Modifiers
programModifiers = defaultModifiers { shortNameModifier = firstLetter }

instance ParseRecord Program where
    parseRecord = parseRecordWithModifiers programModifiers

exec :: IO ()
exec = do
    x <- getRecord "Command-line wrapper around htoml"
    let path = unHelpful $ file x
    contents <- TIO.readFile path
    case parseTomlDoc path contents of
        Right{} -> pure ()
        Left e  -> putStrLn $ parseErrorPretty e
