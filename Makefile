
export RELEASE_DIR ?= $(PWD)/release

all: release deb

deb:
	bash ./scripts/build_deb.sh "$(RELEASE_DIR)"

.PHONY: release
release:
	bash ./scripts/build_snis_builder.sh
	bash ./scripts/release.sh "$(RELEASE_DIR)"

update:
	bash ./scripts/update.sh "$(RELEASE_DIR)"

clean:
	rm -rf output "$(RELEASE_DIR)"
	rm .last_commit
