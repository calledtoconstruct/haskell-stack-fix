{-# LANGUAGE OverloadedStrings #-}

module Main where

import Control.Monad.IO.Class (liftIO)
import Data.Text.IO (putStr, putStrLn)
import           Data.Bifoldable                ( bifold )
import Prelude(IO, ($), return, (<>), Either(..))
import Turtle (shell, inshellWithErr, empty, die, repr, cd, home, fromText, sh, strict, (</>), ExitCode(..))
import Turtle.Line (lineToText)
import Turtle.Shell (Shell(..))

main :: IO ()
main = do
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