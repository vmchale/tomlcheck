next:
    @export VERSION=$(cat tomlcheck.cabal | grep -P -o '\d+\.\d+\.\d+\.\d+' tomlcheck.cabal | head -n1 | awk -F. '{$NF+=1; print $0}' | sed 's/ /\./g') && echo $VERSION && sed -i "2s/[0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+/$VERSION/" tomlcheck.cabal

bench:
    bench "tomlcheck --file data/example.toml" "tomlcheck --file data/good.toml"

upload:
    rm -rf dist/
    cabal sdist
    cabal upload $(fd '.tar.gz$' -IH) --publish

install:
    sn c .
    cabal new-build -O2
    cp $(fd -IH 'tomlcheck$' | tail -n1) ~/.local/bin

release:
    git tag "$(grep -P -o '\d+\.\d+\.\d+\.\d+' tomlcheck.cabal | head -n1)"
    git push origin --tags

check:
    git diff master origin/master
