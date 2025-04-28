#!/usr/bin/env bash
set -eo pipefail

USER="$1"
IMAGE="$2"
if [ -z "$USER" ] || [ -z "$IMAGE" ]; then
    echo "Usage: $0 <username> <image>"
    exit 1
fi

read -rs PASS

curl -s --http1.1 \
    -u "$USER:$PASS" \
    -H "Content-Type: application/json" \
    "https://auth.docker.io/token?service=registry.docker.io&scope=repository:$IMAGE:pull" | jq -r '.token'
