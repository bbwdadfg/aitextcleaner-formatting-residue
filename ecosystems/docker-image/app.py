#!/usr/bin/env python3
import re
import sys
from html import unescape


def clean(text: str) -> str:
    block = re.compile(r"</?(?:address|article|blockquote|br|div|li|p|pre|section)\b[^>]*>", re.I)
    cleaned = re.sub(r"<[^>]*>", "", block.sub("\n", text))
    cleaned = unescape(cleaned).translate(str.maketrans({
        "“": '"', "”": '"', "‘": "'", "’": "'", "–": "-", "—": "-", "…": "...",
    }))
    cleaned = re.sub(r"[ \t]+\n", "\n", cleaned)
    return re.sub(r"\n{3,}", "\n\n", cleaned).strip()


if __name__ == "__main__":
    sys.stdout.write(clean(sys.stdin.read()))
