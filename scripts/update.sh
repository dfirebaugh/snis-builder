#!/bin/bash

# check to see if there is a new commit
# if there is, make a new build

VERSION_FILE=".last_commit"
RELEASE_DIR=${1:-$(pwd)/release}

source ./scripts/get_version.sh

LATEST_COMMIT="${VERSION##*-}"

if [[ -z "$LATEST_COMMIT" ]]; then
    echo "Error: Unable to retrieve commit hash."
    exit 1
fi

if [[ -f "$VERSION_FILE" && "$(cat "$VERSION_FILE")" == "$LATEST_COMMIT" ]]; then
    echo "Commit hash unchanged. Nothing to do."
    exit 0
fi

echo "$LATEST_COMMIT" > "$VERSION_FILE"

echo "New commit detected. Running make..."
make release RELEASE_DIR="$RELEASE_DIR"
make deb RELEASE_DIR="$RELEASE_DIR"
source ./scripts/update_repo.sh

