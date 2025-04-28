#!/usr/bin/env bash
set -eo pipefail

REPO="$1"

# check the provider repo are set
if [ -z "$REPO" ]; then
    echo "Usage: $0 <repo>"
    exit 1
fi

if [ -z "$REGISTRY" ]; then
    REGISTRY="registry-1.docker.io"
fi

if [ -n "$TOKEN" ]; then
    curl -s --http1.1 \
        -H "Authorization: Bearer ${TOKEN}" \
        "https://$REGISTRY/v2/$REPO/tags/list" | jq -r '.tags'
else
    curl -s --http1.1 \
        "http://$REGISTRY/v2/$REPO/tags/list" | jq -r '.tags'
fi
