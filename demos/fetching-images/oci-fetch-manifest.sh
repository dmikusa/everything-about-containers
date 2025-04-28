#!/usr/bin/env bash
set -eo pipefail

REPO="$1"
TAG="$2"

# check the provider repo and tag are set
if [ -z "$REPO" ] || [ -z "$TAG" ]; then
    echo "Usage: $0 <repo> <tag>"
    exit 1
fi

if [ -z "$REGISTRY" ]; then
    REGISTRY="registry-1.docker.io"
fi

if [ -n "$TOKEN" ]; then
    curl -s --http1.1 \
        -H 'Accept: application/vnd.oci.image.manifest.v1+json' \
        -H 'Accept: application/vnd.oci.image.index.v1+json' \
        -H "Authorization: Bearer $TOKEN" \
        "https://$REGISTRY/v2/$REPO/manifests/$TAG" | jq -r '.'
else
    curl -s --http1.1 \
        -H 'Accept: application/vnd.oci.image.manifest.v1+json' \
        -H 'Accept: application/vnd.oci.image.index.v1+json' \
        "http://$REGISTRY/v2/$REPO/manifests/$TAG" | jq -r '.'
fi


