# Haskell Stack Fix

Console program used to fix Stack build errors automatically

# How it works

Stack fix works by running `stack build` and by interpreting the build errors it applies fixes required to the files required to get the build to work.

To use stack-fix:

* run `stack-fix` in the root of your stack project.
* enjoy not having to waste countless hours on fixing build issues which can be fixed automatically by `stack-fix`

# TODO

* allow it to run with custom `stack build` command