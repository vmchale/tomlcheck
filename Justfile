bench VERSION:
    sn c .
    cabal new-build -w ghc-{{ VERSION }}
    export BIN=$(fd -IH 'tomlcheck$' | tail -n1) && bench "$BIN --file Cargo.toml"

upload:
    rm -rf dist/
    cabal sdist
    cabal upload $(fd '.tar.gz$' -IH) --publish

install:
    sn c .
    cabal new-build
    cp $(fd -IH 'tomlcheck$' | tail -n1) ~/.local/bin
