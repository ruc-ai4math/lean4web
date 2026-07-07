#!/usr/bin/env bash

set -euo pipefail

if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
  echo "Usage: $0 <mathlib-version> [output-file]"
  echo "Example: $0 v4.29.0"
  echo "Example: $0 v4.29.0 /tmp/lean4web-mathlib-v4.29.0.tar"
  exit 1
fi

VERSION="$1"
IMAGE_TAG="lean4web:mathlib-${VERSION}"
OUTPUT_FILE="${2:-lean4web-mathlib-${VERSION}.tar}"

docker image inspect "${IMAGE_TAG}" >/dev/null
docker save -o "${OUTPUT_FILE}" "${IMAGE_TAG}"

echo "Exported image ${IMAGE_TAG} -> ${OUTPUT_FILE}"
