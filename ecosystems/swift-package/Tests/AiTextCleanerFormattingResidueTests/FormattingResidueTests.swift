import AiTextCleanerFormattingResidue

@main
struct FormattingResidueTests {
    static func main() {
        assert(
            FormattingResidue.clean("<p>Hello <span>world</span>…</p><div>Next line</div>")
                == "Hello world...\n\nNext line"
        )
    }
}
