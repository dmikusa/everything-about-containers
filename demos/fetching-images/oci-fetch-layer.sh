#!/usr/bin/env bash
set -eo pipefail

REPO="$1"
HASH="$2"

# check the provider repo and hash are set
if [ -z "$REPO" ] || [ -z "$HASH" ]; then
    echo "Usage: $0 <repo> <hash>"
    exit 1
fi

if [ -z "$REGISTRY" ]; then
    REGISTRY="registry-1.docker.io"
fi

if [ -n "$TOKEN" ]; then
    curl -s -L --http1.1 \
        -H "Authorization: Bearer $TOKEN" \
        -o "${REPO/\//-}-${HASH}.tar" \
        "https://$REGISTRY/v2/$REPO/blobs/$HASH" | jq -r '.'
else
    curl -s --http1.1 \
        -o "${REPO/\//-}-${HASH}.tar" \
        "http://$REGISTRY/v2/$REPO/blobs/$HASH" | jq -r '.'
fi

mkdir -p "${REPO/\//-}/${HASH}"
tar -xvf "${REPO/\//-}-${HASH}.tar" -C "${REPO/\//-}/${HASH}"
rm "${REPO/\//-}-${HASH}.tar"
