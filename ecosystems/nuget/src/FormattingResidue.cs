using System;
using System.Net;
using System.Text.RegularExpressions;

namespace AiTextCleaner.FormattingResidue;

public static class FormattingResidue
{
    private static readonly Regex BlockTag = new(
        @"</?(?:address|article|blockquote|br|div|li|p|pre|section)\b[^>]*>",
        RegexOptions.IgnoreCase | RegexOptions.Compiled);
    private static readonly Regex HtmlTag = new("<[^>]*>", RegexOptions.Compiled);

    public static string Clean(string text)
    {
        ArgumentNullException.ThrowIfNull(text);
        var cleaned = BlockTag.Replace(text, "\n");
        cleaned = HtmlTag.Replace(cleaned, string.Empty);
        cleaned = WebUtility.HtmlDecode(cleaned)
            .Replace('“', '"')
            .Replace('”', '"')
            .Replace('‘', '\'')
            .Replace('’', '\'')
            .Replace('–', '-')
            .Replace('—', '-')
            .Replace("…", "...");
        cleaned = Regex.Replace(cleaned, "[ \\t]+\\n", "\\n");
        cleaned = Regex.Replace(cleaned, "\\n{3,}", "\\n\\n");
        return cleaned.Trim();
    }
}
