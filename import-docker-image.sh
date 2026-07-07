#!/usr/bin/env bash

set -euo pipefail

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <image-tar-file>"
  echo "Example: $0 ./lean4web-mathlib-v4.29.0.tar"
  exit 1
fi

IMAGE_FILE="$1"

if [ ! -f "${IMAGE_FILE}" ]; then
  echo "File not found: ${IMAGE_FILE}"
  exit 1
fi

docker load -i "${IMAGE_FILE}"
