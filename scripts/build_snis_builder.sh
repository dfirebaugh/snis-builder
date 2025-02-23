#!/bin/bash

# if we make the dir from within docker, it has the potential to 
# create permissions issues
mkdir -p output/bin
mkdir -p output/share
docker build --build-arg UID=$(id -u) --build-arg GID=$(id -g) -t snis-builder ./deployments/
docker run --rm -v $(pwd)/output:/output snis-builder

