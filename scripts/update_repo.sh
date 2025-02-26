#!/bin/bash

CONTAINER_NAME="aptly"

if ! docker ps --format '{{.Names}}' | grep -q "^$CONTAINER_NAME$"; then
    echo "Error: Docker container '$CONTAINER_NAME' not found or not running."
    exit 1
fi

LATEST_FILE=$(docker exec "$CONTAINER_NAME" sh -c "ls -t /var/lib/aptly/uploads | head -n 1" | tr -d '\r')

if [[ -z "$LATEST_FILE" ]]; then
    echo "Error: No files found in /var/lib/aptly/uploads."
    exit 1
fi

FILE_PATH="/var/lib/aptly/uploads/$LATEST_FILE"

echo "Adding latest file to aptly repo: $LATEST_FILE"
docker exec -it "$CONTAINER_NAME" aptly repo add snis "$FILE_PATH"

echo "Publishing update..."
docker exec -it "$CONTAINER_NAME" aptly publish update bookworm

echo "Aptly repository updated successfully!"

