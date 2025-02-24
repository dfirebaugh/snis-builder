#!/bin/bash

VERSION=1.0.0-latest
source ./scripts/get_version.sh

# if we make the dir from within docker, it has the potential to 
# create permissions issues
mkdir -p output/$VERSION/bin
mkdir -p output/$VERSION/share

docker build \
    --build-arg UID=$(id -u) \
    --build-arg GID=$(id -g) \
    --build-arg VERSION=$VERSION \
    -t snis-builder ./deployments/

docker run --rm -e VERSION=$VERSION -v $(pwd)/output:/output snis-builder

