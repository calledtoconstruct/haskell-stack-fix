# Haskell Stack Fix

Console program used to fix Stack build errors automatically

## How it works

Stack fix works by running `stack build` and by parsing and interpreting the build errors/suggestions it applies any build fixes required to the stack.yaml, .cabal, etc. These fixes usually involve specifying build dependencies versions or adding new build dependencies.

To use stack-fix:

* run `stack-fix` in the root of your stack project
* enjoy not having to waste countless hours on fixing build issues which can be fixed automatically by `stack-fix`

## Contributing

To contribute:

* Fork the project
* Pick any ticket you wish to work on from the project roadmap kanban board that is in the To Do column
* Assign the ticket to yourself and if it makes sense leave a comment detailing at high level what approach you will take
* Implement the feature
* Submit a pull request

Project roadmap kanban board: https://github.com/razvan-panda/haskell-stack-fix/projects/1

### Setting up operating system

#### Windows

We do not support building the project on Windows since many Haskell packages have issues building on Windows.

If you are a Windows user the recommended method is to use WSL or a Linux VMWare virtual machine for your development. The virtual machine option is preffered over WSL since WSL is currently much slower when building stuff than a virtual machine.

#### Linux or MacOS

The project should build fine on these operating systems.

### Setting up build tools

The recommended way to install `cabal-install` is by using the `Nix` package manager.

To install Nix run:

```shell
    curl https://nixos.org/nix/install | sh
```

To install `GHC`, `cabal-install` and `stack`,  create the file `~/.nixpkgs/config.nix`.

Copy paste this into the file:

```nix
let
  config = {
    allowUnfree = true;

    packageOverrides = pkgs: with pkgs;
      let jdk = openjdk11; in rec {
      unstable = import <nixpkgs> { inherit config; };

      all = pkgs.buildEnv {
        name = "all";

        paths = [
          haskell.compiler.ghc864
          haskellPackages.cabal-install
          unstable.haskellPackages.stack
        ];
      };
    };
  };
in config
```

And run following command to install the packages:

```shell
nix-env -i all
```

Run this to update the cabal pacakges:

```shell
cabal v1-update
```

### Building the project

* open a shell window in the `haskell-stack-fix` project root.
* run `cabal v1-install --dependencies-only`
* run the command `cabal v1-build`
