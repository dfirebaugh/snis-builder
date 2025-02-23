#!/bin/bash

# tarball up the binaries

set -e

OUTPUT_DIR=$(pwd)/output
RELEASE_DIR=$(pwd)/release
TARBALL_NAME="snis-$(date +%Y%m%d).tar.gz"

mkdir -p "$RELEASE_DIR"

echo "Packaging release..."
tar -czvf "$RELEASE_DIR/$TARBALL_NAME" -C "$OUTPUT_DIR" .

echo "Release created: $RELEASE_DIR/$TARBALL_NAME"

