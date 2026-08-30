class AitextcleanerFormattingResidue < Formula
  desc "Local formatting-residue cleanup helper for copied text"
  homepage "https://aitextcleaner.pro/"
  url "https://github.com/bbwdadfg/aitextcleaner-formatting-residue/archive/refs/tags/v0.2.0.tar.gz"
  version "0.2.0"
  sha256 :no_check
  license "MIT"

  livecheck :skip

  def install
    bin.install "bin/aitextcleaner-formatting-residue"
  end

  test do
    assert_equal "draft", pipe_output("#{bin}/aitextcleaner-formatting-residue", "<p>draft</p>").strip
  end
end
