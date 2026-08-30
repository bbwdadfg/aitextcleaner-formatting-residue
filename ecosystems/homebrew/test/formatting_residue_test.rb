require "minitest/autorun"
require "open3"

class HomebrewFormattingResidueTest < Minitest::Test
  def test_cli_is_executable
    cli = File.expand_path("../bin/aitextcleaner-formatting-residue", __dir__)
    output, status = Open3.capture2("ruby", cli, stdin_data: "<p>draft</p>")
    assert status.success?
    assert_equal "draft", output
  end
end
