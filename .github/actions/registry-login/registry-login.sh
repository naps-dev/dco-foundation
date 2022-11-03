#!/bin/bash

if [ -n "$1" ]; then
  REGISTRY1_USERNAME=$1
else
  echo "error: registry username must be defined"
  return 1
fi

if [ -n "$2" ]; then
  REGISTRY1_PASSWORD=$2
else
  echo "error: registry password must be defined"
  return 1
fi

zarf tools registry login -u $REGISTRY1_USERNAME -p $REGISTRY1_PASSWORD
