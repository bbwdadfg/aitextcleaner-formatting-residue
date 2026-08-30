from __future__ import annotations

import io
import unittest
from unittest.mock import patch

from aitextcleaner_formatting_residue import clean_formatting_residue
from aitextcleaner_formatting_residue.cli import main


class FormattingResidueTests(unittest.TestCase):
    def test_strips_html_and_preserves_paragraphs(self) -> None:
        source = "<p>Hello <span>world</span>…</p><div>Next line</div>"

        self.assertEqual(clean_formatting_residue(source), "Hello world...\n\nNext line")

    def test_normalizes_typographic_punctuation_and_line_space(self) -> None:
        source = "“quoted” — copy  \nsecond ‘line’"

        self.assertEqual(clean_formatting_residue(source), '"quoted" - copy\nsecond \'line\'')

    def test_rejects_non_string_input(self) -> None:
        with self.assertRaises(TypeError):
            clean_formatting_residue(None)  # type: ignore[arg-type]

    def test_cli_reads_stdin_without_network(self) -> None:
        with patch("sys.stdin", io.StringIO("<p>draft</p>")), patch(
            "sys.stdout", new_callable=io.StringIO
        ) as output:
            exit_code = main([])

        self.assertEqual(exit_code, 0)
        self.assertEqual(output.getvalue(), "draft")


if __name__ == "__main__":
    unittest.main()

