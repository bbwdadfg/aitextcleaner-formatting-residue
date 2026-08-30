require "minitest/autorun"
require "aitextcleaner/formatting_residue"

class FormattingResidueTest < Minitest::Test
  def test_cleans_copied_formatting_residue
    assert_equal(
      "Hello world...\n\nNext line",
      Aitextcleaner::FormattingResidue.clean("<p>Hello <span>world</span>…</p><div>Next line</div>")
    )
  end
end
