#!/bin/bash

echo $1

if [ -n "$1" ]; then
  REGISTRY_USERNAME=$1
else
  echo "error: registry username must be defined"
  exit 1
fi

if [ -n "$2" ]; then
  REGISTRY_PASSWORD=$2
else
  echo "error: registry password must be defined"
  exit 1
fi

if [ -n "$3" ]; then
  REGISTRY_URL=$3
else
  echo "error: registry must be defined"
  exit 1
fi

zarf tools registry login -u $REGISTRY_USERNAME -p $REGISTRY_PASSWORD $REGISTRY_URL
