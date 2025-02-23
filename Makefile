
all: release deb

deb:
	bash ./scripts/build_deb.sh

.PHONY:release
release: 
	bash ./scripts/build_snis_builder.sh
	bash ./scripts/release.sh

clean:
	rm -rf output release
