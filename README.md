# Haskell Stack Fix

Console program used to fix Stack build errors automatically

# How it works

Stack fix works by running `stack build` and by parsing and interpreting the build errors/suggestions it applies any build fixes required to the stack.yaml, .cabal, etc. These fixes usually involve specifying build dependencies versions or adding new build dependencies.

To use stack-fix:

* run `stack-fix` in the root of your stack project
* enjoy not having to waste countless hours on fixing build issues which can be fixed automatically by `stack-fix`