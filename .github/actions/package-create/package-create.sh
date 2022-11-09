#!/bin/bash
set -euo pipefail

if [ -n "$1" ]; then
  BRANCH="$1"
else
  BRANCH="main"
fi

set -x
zarf package create --set BRANCH="$BRANCH" --confirm --skip-sbom
