#!/bin/bash
set -euo pipefail

if [ -n "$1" ]; then
  REGISTRY_USERNAME="$1"
else
  echo "error: registry username must be defined"
  exit 1
fi

if [ -n "$2" ]; then
  REGISTRY_PASSWORD="$2"
else
  echo "error: registry password must be defined"
  exit 1
fi

if [ -n "$3" ]; then
  REGISTRY_URL="$3"
else
  echo "error: registry must be defined"
  exit 1
fi

echo "Logging into $REGISTRY_URL as user: $REGISTRY_USERNAME"
set -x
zarf tools registry login -u "$REGISTRY_USERNAME" -p "$REGISTRY_PASSWORD" "$REGISTRY_URL"
