{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}

module Main
    ( main
    ) where

import           Control.Monad
import qualified Data.Text.IO    as TIO
import           GHC.Generics    (Generic)
import           Options.Generic
import           System.Exit     (ExitCode (..), exitWith)
import           Text.Megaparsec (errorBundlePretty)
import           Text.Toml       (parseTomlDoc)

newtype Program = Program { file :: [FilePath] <?> "Path to file to be checked." }
    deriving (Generic)

programModifiers :: Modifiers
programModifiers = defaultModifiers { shortNameModifier = firstLetter }

instance ParseRecord Program where
    parseRecord = parseRecordWithModifiers programModifiers

main :: IO ()
main = do
    x <- getRecord "Command-line wrapper around htoml"
    let paths = unHelpful (file x)
    contents <- traverse TIO.readFile paths
    case zipWithM parseTomlDoc paths contents of
        Right{} -> mempty
        Left e  -> do
            putStrLn $ errorBundlePretty e
            exitWith (ExitFailure 1)
