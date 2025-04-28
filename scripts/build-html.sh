#!/usr/bin/env bash
set -eo pipefail

if [ ! -d "./slides" ]; then
    echo "Error: slides directory not found. Please run this script from the root of the repository."
    exit 1
fi

rm -rf ./out/
mkdir ./out/
cp -R ./slides/img out/img
marp -o ./out/ \
    -I ./slides \
    --no-config-file \
    --html \
    --title "Everything you wanted to know about containers but were afraid to ask" \
    --author "Daniel Mikusa" \
    --keywords "containers, docker, kubernetes" \
    --url "https://github.com/dmikusa/everything-about-containers"
