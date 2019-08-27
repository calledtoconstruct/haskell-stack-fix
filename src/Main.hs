{-# LANGUAGE OverloadedStrings, FlexibleInstances, GADTs #-}

module Main where

import Control.Monad.IO.Class (liftIO)
import Data.Text (pack)
import Data.Text.IO (putStr, putStrLn)
import           Data.Bifoldable                ( bifold )
import Prelude(IO, ($), return, (<>), Either(..), Bool(..), (<$>))
import Turtle (shell, inshellWithErr, empty, die, repr, cd, home, fromText, sh, strict, (</>), ExitCode(..))
import Turtle.Line (lineToText)
import Turtle.Shell (Shell(..))
import Paths_stack_fix (version)
import Data.Version (showVersion)
import Control.Applicative (pure, (<*>))
import Options (runCommand, Options(..), defineOptions, simpleOption)
import System.Exit (exitSuccess)


newtype CmdOptions = CmdOptions {
  printVersion :: Bool
}

instance (opts ~ CmdOptions) => Options opts where
  defineOptions = CmdOptions <$> simpleOption "version" False
        "Print the version of stack-fix."

main :: IO ()
main = runCommand $ \opts args ->
  if printVersion opts
    then do
      putStrLn (pack $ showVersion version)
      exitSuccess
    else do
      putStrLn "cd to project root"
      homeDir <- home
      cd $ homeDir </> fromText "Forks/snowdrift"
      putStrLn "cd to project root finished"

      putStrLn "Starting nix-shell"
      exitCode <- shell "nix-shell" empty
      case exitCode of
          ExitSuccess   -> return ()
          ExitFailure n -> die ("`nix-shell` failed with exit code: " <> repr n)
      putStrLn "Opened nix-shell"

      putStrLn "Running direnv allow"
      exitCode <- shell "direnv allow" empty
      case exitCode of
          ExitSuccess   -> return ()
          ExitFailure n -> die ("`direnv allow` failed with exit code: " <> repr n)
      putStrLn "Finished direnv allow"

      putStrLn "Starting `stack build`"
      sh runStackBuild
      putStrLn "Finished `stack build`"

runStackBuild :: Shell ()
runStackBuild = do
  out <- inshellWithErr "stack build" empty
  liftIO $ putStrLn $ lineToText $ bifold out
