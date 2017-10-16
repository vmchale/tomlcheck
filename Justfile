clean:
    sn c .

compare:
    cabal new-build -O2 --constraint='tomlcheck +native'
    cp $(fd -IH 'tomlcheck$' | tail -n1) ~/.local/bin
    bench "rust-tomlcheck --file data/sample.toml" "tomlcheck --file data/sample.toml" "rust-tomlcheck --file data/bad.toml" "tomlcheck --file data/bad.toml"
    
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
    git tag -d "$(grep -P -o '\d+\.\d+\.\d+\.\d+' tomlcheck.cabal | head -n1)"

name:
    github-release edit -s $(cat .git-token) -u vmchale -r tomlcheck -n "$(madlang run ~/programming/madlang/releases/releases.mad)" -t "$(grep -P -o '\d+\.\d+\.\d+\.\d+' tomlcheck.cabal | head -n1)"

check:
    git diff master origin/master
