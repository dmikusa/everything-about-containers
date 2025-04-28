#!/usr/bin/env bash
set -eo pipefail

USER="$1"
REPO="$2"

# check the provider user and repo are set
if [ -z "$USER" ] || [ -z "$REPO" ]; then
    echo "Usage: $0 <username> <repo>"
    exit 1
fi

read -r TOKEN

curl -s --http1.1 \
    -H "Content-Type: application/json" \
    -H "Authorization: bearer $TOKEN" \
    "https://hub.docker.com/v2/repositories/$USER/$REPO/tags/?page_size=10000" | jq -r '.'