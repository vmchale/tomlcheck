bench:
    bench "tomlcheck --file data/example.toml"

upload:
    rm -rf dist/
    cabal sdist
    cabal upload $(fd '.tar.gz$' -IH) --publish

install:
    sn c .
    cabal new-build
    cp $(fd -IH 'tomlcheck$' | tail -n1) ~/.local/bin

release TAG:
    git tag {{ TAG }}
    git push origin --tags

check:
    git diff master origin/master
