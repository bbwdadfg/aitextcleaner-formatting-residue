"""Turn simple copied HTML and typographic residue into clean plain text."""

from __future__ import annotations

import re
from html.parser import HTMLParser

_BLOCK_TAGS = {"address", "article", "blockquote", "br", "div", "li", "p", "pre", "section"}
_TYPOGRAPHIC_TRANSLATION = str.maketrans(
    {
        "“": '"',
        "”": '"',
        "‘": "'",
        "’": "'",
        "–": "-",
        "—": "-",
        "…": "...",
    }
)


class _PlainTextExtractor(HTMLParser):
    """Extract text while retaining meaningful copied-document breaks."""

    def __init__(self) -> None:
        super().__init__(convert_charrefs=True)
        self.parts: list[str] = []

    def handle_starttag(self, tag: str, attrs: list[tuple[str, str | None]]) -> None:
        if tag.lower() in _BLOCK_TAGS:
            self.parts.append("\n")

    def handle_endtag(self, tag: str) -> None:
        if tag.lower() in _BLOCK_TAGS:
            self.parts.append("\n")

    def handle_data(self, data: str) -> None:
        self.parts.append(data)

    def text(self) -> str:
        return "".join(self.parts)


def clean_formatting_residue(text: str) -> str:
    """Strip copied HTML and normalize typographic formatting to plain text.

    This function is deterministic, performs no network access, and keeps
    paragraph breaks while removing presentation-only markup.
    """
    if not isinstance(text, str):
        raise TypeError("text must be a string")

    extractor = _PlainTextExtractor()
    extractor.feed(text)
    extractor.close()

    cleaned = extractor.text().translate(_TYPOGRAPHIC_TRANSLATION)
    cleaned = re.sub(r"[ \t]+\n", "\n", cleaned)
    cleaned = re.sub(r"\n{3,}", "\n\n", cleaned)
    return cleaned.strip()

