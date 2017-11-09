{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}

module Toml.Checker
    ( exec
    ) where

import           Control.Monad   (zipWithM)
import qualified Data.Text.IO    as TIO
import           GHC.Generics    (Generic)
import           Options.Generic
import           System.Exit     (ExitCode (..), exitWith)
import           Text.Megaparsec (parseErrorPretty)
import           Text.Toml       (parseTomlDoc)

newtype Program = Program { files :: [FilePath] <?> "Path to file to be checked." }
    deriving (Generic)

programModifiers :: Modifiers
programModifiers = defaultModifiers { shortNameModifier = firstLetter }

instance ParseRecord Program where
    parseRecord = parseRecordWithModifiers programModifiers

exec :: IO ()
exec = do
    x <- getRecord "Command-line wrapper around htoml"
    let paths = unHelpful $ files x
    contents <- traverse TIO.readFile paths
    case zipWithM parseTomlDoc paths contents of
        Right _ -> pure ()
        Left e  -> do
            putStrLn $ parseErrorPretty e
            exitWith (ExitFailure 1)
