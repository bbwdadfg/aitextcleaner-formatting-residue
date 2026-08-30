#!/bin/sh
set -eu
grep -q '0.2.0' metadata.json
grep -q 'candidate' metadata.json
grep -q 'aitextcleaner.pro' metadata.json
test -s tools/chocolateyInstall.ps1
