#!/bin/bash

if [ -n "$1" ]; then
  BRANCH=$1
else
  BRANCH="main"
fi

zarf package create --set BRANCH=$BRANCH --confirm
