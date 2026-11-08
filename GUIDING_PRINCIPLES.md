# Guiding principles: calledtoconstruct/haskell-stack-fix

## Purpose and scope
`stack-fix`: a console program that runs `stack build`, reads the errors and applies fixes to `stack.yaml`/`.cabal` (dependency versions, missing dependencies).

## Stack and layout
Haskell2010, Cabal file `stack-fix.cabal` (one executable, sources in `src/`), Stack (`stack.yaml`, resolver lts-14.1, `system-ghc: true`), `shell.nix`. Depends on turtle, text, options.

## Commands
| Check | Command | Evidence |
|---|---|---|
| Setup | Nix-based toolchain per README | README.md |
| Build | `stack build` (Stack project; the tool itself wraps this command) | stack.yaml, README.md |
| Type-check | Covered by the GHC build | - |
| Tests | None: no test-suite in the Cabal file | stack-fix.cabal |
| CI | None | repository tree |

Commands marked as not written down come from the build files, not from project docs; confirm them before relying on them.

## Before every push
Before every push: run the build and type-check/lint that exist here, plus only the tests for the files or feature you changed (team rule, ideas #14 note 6797). Do not run the full suite locally as a routine gate; this repository has no CI that runs the full suite, so run the full suite only when the change is broad, and say in the PR that CI coverage is missing. Merge needs a positive review. Explain any new failure your change caused. Never weaken a valid test to make it pass, and never invent a command this file does not list.

## Project rules
- Windows is not supported (README); do not add Windows-specific code paths.
- Keep exact dependency pins in the Cabal file consistent with the Stack resolver.

## What to avoid
- Committing to the default branch; work on a branch and open a pull request.
- Deleting files, branches or history, or changing repository settings.
- Adding tooling, CI or dependencies that the change does not need.
- Rules copied from other projects (file-size limits, clocks, quotas) that this repository never adopted.

## Delivery and safety
- Nothing is released from this repository.

## Open questions
- No tests or CI. Upstream links in the Cabal file point at razvan-panda/haskell-stack-fix; which repo is canonical is not stated.

## Sources
Read from the `master` branch on 2026-11-08 ET: `README.md`, `stack-fix.cabal`, `stack.yaml`, `shell.nix`.

## Instruction updates
Check `guiding-principles.version` at the start of each turn and when you enter this project; reload this file when the version changes. Change this file, its version and date, and `PRINCIPLES_HISTORY.md` in the same commit. Team-wide role instructions are versioned separately in the team-process repository.
