module Main
    ( main
    ) where

import           Control.Monad
import qualified Data.Text.IO        as TIO
import           Data.Version        (showVersion)
import           Options.Applicative
import           Paths_tomlcheck     (version)
import           System.Exit         (ExitCode (..), exitWith)
import           Text.Megaparsec     (errorBundlePretty)
import           Text.Toml           (parseTomlDoc)

versionInfo :: Parser (a -> a)
versionInfo = infoOption ("tomlchecl version: " ++ showVersion version) (short 'V' <> long "version" <> help "Show version")

tomlFile :: Parser [FilePath]
tomlFile = some
    (strOption
    (metavar "FILE"
    <> long "file"
    <> short 'f'
    <> help "Path to file to be checked"
    ))

wrapper :: ParserInfo [FilePath]
wrapper = info (helper <*> versionInfo <*> tomlFile)
    (fullDesc
    <> progDesc "A TOML syntax checker"
    <> header "tomlcheck - a syntax checker for TOML written in Haskell")

main :: IO ()
main = execParser wrapper >>= run

run :: [FilePath] -> IO ()
run paths = do
    contents <- traverse TIO.readFile paths
    case zipWithM parseTomlDoc paths contents of
        Right{} -> mempty
        Left e -> do
            putStrLn $ errorBundlePretty e
            exitWith (ExitFailure 1)
