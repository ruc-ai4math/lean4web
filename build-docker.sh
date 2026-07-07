#!/usr/bin/env bash

set -euo pipefail

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <mathlib-version>"
  echo "Example: $0 v4.29.0"
  exit 1
fi

VERSION="$1"
IMAGE_TAG="lean4web:mathlib-${VERSION}"

docker build \
  --build-arg LEANWEB_BUILD_PROJECT=MathlibDemo \
  --build-arg LEANWEB_PROJECT_VERSION="${VERSION}" \
  -t "${IMAGE_TAG}" \
  .

echo "Built image: ${IMAGE_TAG}"
