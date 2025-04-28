#!/usr/bin/env bash
set -eo pipefail

USER="$1"

# Check if the user provided a username
if [ -z "$USER" ]; then
    echo "Usage: $0 <username>"
    exit 1
fi

read -r TOKEN

curl -s --http1.1 \
    -H "Content-Type: application/json" \
    -H "Authorization: bearer $TOKEN" \
    "https://hub.docker.com/v2/repositories/$USER?page_size=10000" | jq -r '.results|.[]|.name'