#!/usr/bin/env bash
set -eo pipefail

USER="$1"
REPO="$2"
TAG="$3"

# check the user, repo and tag are set
if [ -z "$USER" ] || [ -z "$REPO" ] || [ -z "$TAG" ]; then
    echo "Usage: $0 <username> <repo> <tag>"
    exit 1
fi

read -r TOKEN

curl -s --http1.1 \
    -H "Content-Type: application/json" \
    -H "Authorization: bearer $TOKEN" \
    "https://hub.docker.com/v2/repositories/$USER/$REPO/tags/$TAG" | jq -r '.'