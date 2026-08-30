#!/bin/sh
set -eu
grep -q 'org.opencontainers.image.version.*0.2.0' Containerfile
grep -q 'org.opencontainers.image.source.*aitextcleaner.pro' Containerfile
actual=$(printf '%s' '<p>draft</p>' | python3 app.py)
[ "$actual" = 'draft' ]
