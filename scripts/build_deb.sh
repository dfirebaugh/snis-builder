#!/bin/bash

VERSION=1.0.0-latest
source ./scripts/build_snis_builder.sh
source ./scripts/get_version.sh


if ! docker images | grep -q "snis-builder"; then
    echo "Error: snis-builder image not found. Build it first."
    exit 1
fi

docker build \
    --build-arg VERSION=$VERSION \
    -t snis-deb -f ./deployments/deb.dockerfile .

docker run --rm -e VERSION=$VERSION -v $(pwd)/release:/release snis-deb

