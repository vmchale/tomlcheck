bench:
    bench "tomlcheck --file data/sample.toml"

install:
    cabal new-build
    cp $(fd -IH 'tomlcheck$' | tail -n1) ~/.local/bin
    cp tomlcheck.usage ~/.compleat

name:
    github-release edit -s $(cat .git-token) -u vmchale -r tomlcheck -n "$(madlang run ~/programming/madlang/releases/releases.mad)" -t "$(grep -P -o '\d+\.\d+\.\d+\.\d+' tomlcheck.cabal | head -n1)"
