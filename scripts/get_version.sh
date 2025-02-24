#!/bin/bash

REPO_OWNER="smcameron"
REPO_NAME="space-nerds-in-space"

LATEST_TAG=$(curl -s "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/releases/latest" | jq -r '.tag_name' 2>/dev/null)

if [[ "$LATEST_TAG" =~ ^v ]]; then
    BASE_VERSION="${LATEST_TAG:1}"
else
    BASE_VERSION="$LATEST_TAG"
fi

LATEST_COMMIT=$(git ls-remote https://github.com/$REPO_OWNER/$REPO_NAME.git HEAD | awk '{print substr($1, 1, 7)}')

if [[ -z "$BASE_VERSION" || -z "$LATEST_COMMIT" ]]; then
    echo "Error: Unable to retrieve version or commit hash."
    exit 1
fi

FULL_VERSION="${BASE_VERSION}-${LATEST_COMMIT}"

export VERSION="$FULL_VERSION"
