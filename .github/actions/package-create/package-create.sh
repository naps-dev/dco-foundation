#!/bin/bash

if [ -n "$1" ]; then
  BRANCH=$1
else
  BRANCH="main"

zarf package create --set BRANCH=$BRANCH
