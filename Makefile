CRBIN=crystal
LGBIN=lib/libgen/bin/libgen
LGCONF=lib.yml
GENSRC=src/lib_transformer.cr

generate_lib: $(LGBIN) $(LGCONF)
	rm -rf src/lib_icu
	$(LGBIN) $(LGCONF)
	$(CRBIN) run $(GENSRC)

$(LGBIN): lib/libgen
	cd lib/libgen && $(CRBIN) deps build

lib/libgen: shard.yml
	$(CRBIN) deps install

benchmark:
	find bench/ -name "*_bench.cr" -exec \
		sh -c 'echo {} && $(CRBIN) run --release {}' \;

clean:
	rm -rf lib
	rm -rf .crystal

.PHONY: generate_lib benchmark clean
