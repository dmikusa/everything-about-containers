#!/usr/bin/env bash
set -eo pipefail

USER="$1"
echo -n 'Password: '
read -rs PASS
echo

# Check if the user provided a username and password
if [ -z "$USER" ] || [ -z "$PASS" ]; then
    echo "Usage: $0 <username>"
    exit 1
fi

BODY='{"identifier":"'"$USER"'","secret":"'"$PASS"'"}'
TOKEN=$(curl -s --http1.1 \
    -H "Content-Type: application/json" \
    -d "$BODY" \
    https://hub.docker.com/v2/auth/token | jq -r '.access_token')
echo "$TOKEN"
    