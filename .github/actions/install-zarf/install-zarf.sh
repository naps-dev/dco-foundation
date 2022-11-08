#!/bin/bash
set -euo pipefail
set -x

curl -s -O -L https://github.com/defenseunicorns/zarf/releases/download/v0.22.2/zarf_v0.22.2_Linux_amd64
sudo install -g root -o root -m 0777 zarf_v0.22.2_Linux_amd64 /usr/local/bin/zarf
zarf version
