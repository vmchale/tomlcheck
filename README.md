# tomlcheck

[![Build Status](https://travis-ci.org/vmchale/tomlcheck.svg?branch=master)](https://travis-ci.org/vmchale/tomlcheck)

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
 $ cabal install tomlcheck
```

## Known Deficiencies

  * No Windows binaries
  * Slow on large files (>= 7000 lines)

## Cool Facts
  
  * It's really fast
  * It uses laziness to make checking schnell yet robust
