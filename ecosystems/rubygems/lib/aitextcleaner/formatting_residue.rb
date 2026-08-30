require "cgi"

module Aitextcleaner
  module FormattingResidue
    BLOCK_TAG = /<\/?(?:address|article|blockquote|br|div|li|p|pre|section)\b[^>]*>/i
    HTML_TAG = /<[^>]*>/

    module_function

    def clean(text)
      raise TypeError, "text must be a string" unless text.is_a?(String)

      cleaned = text.gsub(BLOCK_TAG, "\n").gsub(HTML_TAG, "")
      cleaned = CGI.unescapeHTML(cleaned)
      cleaned = cleaned.gsub("“", '"').gsub("”", '"').gsub("‘", "'").gsub("’", "'")
        .gsub("–", "-").gsub("—", "-").gsub("…", "...")
      cleaned.gsub(/[ \t]+\n/, "\n").gsub(/\n{3,}/, "\n\n").strip
    end
  end
end
