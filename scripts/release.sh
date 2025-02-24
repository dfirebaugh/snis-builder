#!/bin/bash

# tarball up the binaries

set -e

VERSION=1.0.0-latest
source ./scripts/get_version.sh

OUTPUT_DIR=$(pwd)/output
RELEASE_DIR=$(pwd)/release
TARBALL_NAME="snis-${VERSION}.tar.gz"

mkdir -p "$RELEASE_DIR"

echo "Packaging release..."
tar -czvf "$RELEASE_DIR/$TARBALL_NAME" -C "$OUTPUT_DIR" .

echo "Release created: $RELEASE_DIR/$TARBALL_NAME"

