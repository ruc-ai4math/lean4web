#!/usr/bin/env bash

set -euo pipefail

# Operate in the directory where this file is located
cd "$(dirname "$0")"

MATHLIB_REV="${LEANWEB_PROJECT_VERSION:-${MATHLIB_REV:-master}}"
MATHLIB_TOOLCHAIN_URL="https://raw.githubusercontent.com/leanprover-community/mathlib4/${MATHLIB_REV}/lean-toolchain"

echo "Using mathlib revision: ${MATHLIB_REV}"

# Keep lakefile pinned to the requested revision so `lake update -R` only
# fetches the matching mathlib dependency graph.
escaped_mathlib_rev="$(printf "%s" "${MATHLIB_REV}" | sed 's/[\\&/]/\\&/g')"
sed -i "s/^rev = \".*\"$/rev = \"${escaped_mathlib_rev}\"/" lakefile.toml

# Fetch the matching Lean toolchain used by this exact mathlib revision.
curl -fsSL "${MATHLIB_TOOLCHAIN_URL}" -o lean-toolchain

# Force a clean dependency resolve for revision switches.
rm -f lake-manifest.json
rm -rf .lake/packages/mathlib .lake/packages/batteries

lake update -R
lake build
lake build Batteries
