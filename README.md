# tomlcheck

[![Build Status](https://travis-ci.org/vmchale/tomlcheck.svg?branch=master)](https://travis-ci.org/vmchale/tomlcheck)
[![Windows build status](https://ci.appveyor.com/api/projects/status/github/vmchale/tomlcheck?svg=true)](https://ci.appveyor.com/project/vmchale/tomlcheck)
[![Hackage CI](https://matrix.hackage.haskell.org/api/v2/packages/tomlcheck/badge)](https://matrix.hackage.haskell.org/package/tomlcheck)
[![Hackage](https://img.shields.io/hackage/v/tomlcheck.svg)](http://hackage.haskell.org/package/tomlcheck)
[![Dependencies of latest version on Hackage](https://img.shields.io/hackage-deps/v/tomlcheck.svg)](https://hackage.haskell.org/package/tomlcheck)

`tomlcheck` is a command-line wrapper around the `htoml` library which can be
used as a syntax checker for TOML.

You can find a vim plugin [here](https://github.com/vmchale/tomlcheck-vim).

## Installation

### Binaries

Head over to the [release page](https://github.com/vmchale/tomlcheck/releases) to see if your platform has
binaries. Simply put it somewhere on your path.

### Cabal

Install [GHC](https://www.haskell.org/ghc/download.html) along with 
[cabal](https://www.haskell.org/downloads#minimal), then

```bash
 $ cabal update
 $ cabal new-install tomlcheck
```

## Use

### Travis

Add the following your `.travis.yml` file to check a file called `Config.toml`:

```yaml
  - curl -sL https://raw.githubusercontent.com/vmchale/tomlcheck/master/sh/check | sh -s Config.toml
```
