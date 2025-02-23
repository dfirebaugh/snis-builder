#!/bin/bash

source ./scripts/build_snis_builder.sh

if ! docker images | grep -q "snis-builder"; then
    echo "Error: snis-builder image not found. Build it first."
    exit 1
fi

docker build -t snis-deb -f ./deployments/deb.dockerfile .

mkdir -p output/deb
docker run --rm -v $(pwd)/output:/output snis-deb

