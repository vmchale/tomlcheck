.PHONY: bench install

bench:
	bench "tomlcheck --file data/sample.toml"

install:
	cabal new-install exe:tomlcheck --overwrite-policy=always
	cp tomlcheck.usage ~/.compleat
