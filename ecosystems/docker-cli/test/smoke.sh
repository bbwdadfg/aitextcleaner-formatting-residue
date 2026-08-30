#!/bin/sh
set -eu
cli=$(CDPATH= cd -- "$(dirname "$0")/../bin" && pwd)/aitextcleaner-formatting-residue
actual=$(printf '%s' '<p>Hello <span>world</span>…</p><div>Next line</div>' | "$cli")
[ "$actual" = 'Hello world...

Next line' ]
