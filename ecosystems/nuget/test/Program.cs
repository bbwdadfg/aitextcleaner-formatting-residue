using AiTextCleaner.FormattingResidue;

var actual = FormattingResidue.Clean("<p>Hello <span>world</span>…</p><div>Next line</div>");
const string expected = "Hello world...\n\nNext line";
if (actual != expected)
{
    throw new Exception($"Clean() = {actual}, want {expected}");
}
