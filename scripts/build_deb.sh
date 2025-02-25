#!/bin/bash

RELEASE_DIR=${1:-$(pwd)/release}

mkdir -p "$RELEASE_DIR"

source ./scripts/build_snis_builder.sh
source ./scripts/get_version.sh

if ! docker images | grep -q "snis-builder"; then
    echo "Error: snis-builder image not found. Build it first."
    exit 1
fi

docker build \
    --build-arg VERSION="$VERSION" \
    -t snis-deb -f ./deployments/deb.dockerfile .

docker run --rm -e VERSION="$VERSION" -v "$RELEASE_DIR:/release" snis-deb
