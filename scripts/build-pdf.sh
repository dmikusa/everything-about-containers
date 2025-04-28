#!/usr/bin/env bash
set -eo pipefail

if [ ! -d "./slides" ]; then
    echo "Error: slides directory not found. Please run this script from the root of the repository."
    exit 1
fi

rm -rf ./out/
mkdir ./out/
marp -o ./out/ \
    -I ./slides \
    --no-config-file \
    --pdf \
    --pdf-notes \
    --browser chrome \
    --browser-path /Applications/Brave\ Browser.app/Contents/MacOS/Brave\ Browser \
    --title "Everything you wanted to know about containers but were afraid to ask" \
    --author "Daniel Mikusa" \
    --keywords "containers, docker, kubernetes" \
    --url "https://github.com/dmikusa/everything-about-containers"
