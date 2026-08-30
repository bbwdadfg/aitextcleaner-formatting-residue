package pro.aitextcleaner;

public final class FormattingResidueSmoke {
    public static void main(String[] args) {
        String actual = FormattingResidue.clean("<p>Hello <span>world</span>…</p><div>Next line</div>");
        String expected = "Hello world...\n\nNext line";
        if (!expected.equals(actual)) {
            throw new AssertionError("clean() = " + actual + ", want " + expected);
        }
    }
}
