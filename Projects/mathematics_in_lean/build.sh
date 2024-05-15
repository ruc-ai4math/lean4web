#!/usr/bin/env bash

# Operate in the directory where this file is located
cd $(dirname $0)


# Note: we had once problems with the `lake-manifest` when a new dependency got added
# to `mathlib`, we may need to add `rm lake-manifest.json` again if that's still a problem.

# currently the mathlib post-update-hook is not good enough to update the lean-toolchain.
# things break if the new lakefile is not valid in the old lean version
curl -L https://github.com/leanprover-community/mathematics_in_lean/raw/master/lean-toolchain -o lean-toolchain

# note: mathlib has now a post-update hook that modifies the `lean-toolchain`
# and calls `lake exe cache get`.
lake update -R
lake build
