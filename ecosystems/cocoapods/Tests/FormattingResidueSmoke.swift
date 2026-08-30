import Foundation

@main
struct FormattingResidueSmoke {
    static func main() {
        let actual = FormattingResidue.clean("<p>Hello <span>world</span>…</p><div>Next line</div>")
        let expected = "Hello world...\n\nNext line"
        guard actual == expected else {
            fatalError("clean() = \(actual), want \(expected)")
        }
    }
}
