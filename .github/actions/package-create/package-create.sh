#!/bin/bash

if [ -n "$1" ]; then
  BRANCH=$1
else
  BRANCH="main"
fi

zarf package create --set BRANCH=$BRANCH --confirm --skip-sbom

mkdir out
mv zarf-package-dco-foundation-amd64.tar.zst out/
