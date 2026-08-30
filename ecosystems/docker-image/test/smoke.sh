#!/bin/sh
set -eu
actual=$(printf '%s' '<p>Hello <span>world</span>…</p><div>Next line</div>' | python3 app.py)
[ "$actual" = 'Hello world...

Next line' ]
