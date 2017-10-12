clean:
    sn c .
    rm -f lol.html

lol:
    bench "sn help" "tomlcheck --file data/example.toml" --output lol.html

next:
    @export VERSION=$(cat tomlcheck.cabal | grep -P -o '\d+\.\d+\.\d+\.\d+' tomlcheck.cabal | head -n1 | awk -F. '{$NF+=1; print $0}' | sed 's/ /\./g') && echo $VERSION && sed -i "2s/[0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+/$VERSION/" tomlcheck.cabal

bench:
    bench "tomlcheck --file data/example.toml" "tomlcheck --file data/good.toml"

upload:
    rm -rf dist/
    cabal sdist
    cabal upload $(fd '.tar.gz$' -IH) --publish

install:
    cabal new-build
    cp $(fd -IH 'tomlcheck$' | tail -n1) ~/.local/bin

release:
    git tag "$(grep -P -o '\d+\.\d+\.\d+\.\d+' tomlcheck.cabal | head -n1)"
    git push origin --tags
    github-release edit -s $(cat .git-token) -u vmchale -r tomlcheck -n $(madlang run ~/programming/madlang/releases/releases.mad) -t "$(grep -P -o '\d+\.\d+\.\d+\.\d+' tomlcheck.cabal | head -n1)"

check:
    git diff master origin/master
