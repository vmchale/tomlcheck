upload:
    rm -rf dist/
    cabal sdist
    cabal upload $(fd '.tar.gz$' -IH) --publish

install:
    sn c .
    cabal new-build -w ghc-8.0.2
    cp $(fd -IH 'tomlcheck$' | tail -n1) ~/.local/bin
