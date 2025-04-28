#!/usr/bin/env bash
set -eo pipefail

read -r TOKEN

curl -s --http1.1 \
    -H "Content-Type: application/json" \
    -H "Authorization: bearer $TOKEN" \
    https://hub.docker.com/v2/repositories/namespaces | jq .