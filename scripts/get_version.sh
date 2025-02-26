#!/bin/bash

REPO_OWNER="smcameron"
REPO_NAME="space-nerds-in-space"
REPO_URL="https://github.com/$REPO_OWNER/$REPO_NAME.git"

LATEST_TAG=$(curl -s "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/releases/latest" | jq -r '.tag_name' 2>/dev/null)

if [[ "$LATEST_TAG" =~ ^v ]]; then
    BASE_VERSION="${LATEST_TAG:1}"
else
    BASE_VERSION="$LATEST_TAG"
fi

TAG_COMMIT_HASH=$(git ls-remote --tags "$REPO_URL" | grep "refs/tags/$LATEST_TAG$" | awk '{print substr($1, 1, 7)}')

LATEST_COMMIT_HASH=$(git ls-remote "$REPO_URL" HEAD | awk '{print substr($1, 1, 7)}')

COMMITS_SINCE_TAG=$(curl -s "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/compare/$LATEST_TAG...HEAD" | jq -r '.total_commits' 2>/dev/null || echo "0")

if [[ -z "$BASE_VERSION" || -z "$TAG_COMMIT_HASH" || -z "$LATEST_COMMIT_HASH" || -z "$COMMITS_SINCE_TAG" ]]; then
    echo "Error: Unable to retrieve version components."
    exit 1
fi

FULL_VERSION="${BASE_VERSION}.${COMMITS_SINCE_TAG}-${TAG_COMMIT_HASH}"

export VERSION="$FULL_VERSION"

echo "Generated version: $VERSION"

