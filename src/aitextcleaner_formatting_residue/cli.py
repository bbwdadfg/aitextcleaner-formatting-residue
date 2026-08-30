"""Command-line interface for formatting-residue cleanup."""

from __future__ import annotations

import argparse
import sys
from pathlib import Path
from typing import Sequence

from .cleaner import clean_formatting_residue


def main(argv: Sequence[str] | None = None) -> int:
    """Read copied text from stdin or one UTF-8 file and print cleaned text."""
    parser = argparse.ArgumentParser(
        description="Strip copied HTML and typographic formatting residue."
    )
    parser.add_argument("input_file", nargs="?", help="Optional UTF-8 text file.")
    args = parser.parse_args(argv)

    text = Path(args.input_file).read_text(encoding="utf-8") if args.input_file else sys.stdin.read()
    sys.stdout.write(clean_formatting_residue(text))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

