package pro.aitextcleaner;

import java.util.regex.Pattern;

public final class FormattingResidue {
    private static final Pattern BLOCK_TAG = Pattern.compile(
        "</?(?:address|article|blockquote|br|div|li|p|pre|section)\\b[^>]*>", Pattern.CASE_INSENSITIVE);
    private static final Pattern HTML_TAG = Pattern.compile("<[^>]*>");
    private static final Pattern SPACE_BEFORE_NEWLINE = Pattern.compile("[ \\t]+\\n");
    private static final Pattern MANY_NEWLINES = Pattern.compile("\\n{3,}");

    private FormattingResidue() {}

    public static String clean(String text) {
        if (text == null) throw new NullPointerException("text must not be null");
        String cleaned = BLOCK_TAG.matcher(text).replaceAll("\\n");
        cleaned = HTML_TAG.matcher(cleaned).replaceAll("");
        cleaned = decodeEntities(cleaned)
            .replace('“', '"')
            .replace('”', '"')
            .replace('‘', '\'')
            .replace('’', '\'')
            .replace('–', '-')
            .replace('—', '-')
            .replace("…", "...");
        cleaned = SPACE_BEFORE_NEWLINE.matcher(cleaned).replaceAll("\\n");
        cleaned = MANY_NEWLINES.matcher(cleaned).replaceAll("\\n\\n");
        return cleaned.trim();
    }

    private static String decodeEntities(String text) {
        return text.replace("&amp;", "&")
            .replace("&lt;", "<")
            .replace("&gt;", ">")
            .replace("&quot;", "\"")
            .replace("&#39;", "'")
            .replace("&apos;", "'")
            .replace("&nbsp;", " ");
    }
}
