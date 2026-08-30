#!/usr/bin/env python3
import re
import sys
from html import unescape

text = sys.stdin.read()
text = re.sub(r"<[^>]*>", "", re.sub(r"</?(?:address|article|blockquote|br|div|li|p|pre|section)\b[^>]*>", "\n", text, flags=re.I))
text = unescape(text).translate(str.maketrans({"“": '"', "”": '"', "‘": "'", "’": "'", "–": "-", "—": "-", "…": "..."}))
text = re.sub(r"[ \t]+\n", "\n", text)
sys.stdout.write(re.sub(r"\n{3,}", "\n\n", text).strip())
