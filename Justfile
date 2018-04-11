ci:
    cabal new-build
    hlint app
    yamllint stack.yaml
    yamllint .travis.yml
    yamllint appveyor.yml
    yamllint .stylish-haskell.yaml
    yamllint .hlint.yaml
    stack build
    weeder .

poly:
    @poly -e README.md -e TODO.md -e data/ -e Justfile .

next:
    @export VERSION=$(cat tomlcheck.cabal | grep -P -o '\d+\.\d+\.\d+\.\d+' tomlcheck.cabal | head -n1 | awk -F. '{$NF+=1; print $0}' | sed 's/ /\./g') && echo $VERSION && sed -i "3s/[0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+/$VERSION/" tomlcheck.cabal && sed -i "4,8s/[0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+/$VERSION/" sh/check

bench:
    bench "tomlcheck --file data/sample.toml"

install:
    cabal new-build -O2
    cp $(fd -IH 'tomlcheck$' | tail -n1) ~/.local/bin

name:
    github-release edit -s $(cat .git-token) -u vmchale -r tomlcheck -n "$(madlang run ~/programming/madlang/releases/releases.mad)" -t "$(grep -P -o '\d+\.\d+\.\d+\.\d+' tomlcheck.cabal | head -n1)"

check:
    git diff master origin/master
