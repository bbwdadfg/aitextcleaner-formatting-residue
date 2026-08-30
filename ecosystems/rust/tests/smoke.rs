use aitextcleaner_formatting_residue::clean_formatting_residue;

#[test]
fn cleans_copied_formatting_residue() {
    assert_eq!(
        clean_formatting_residue("<p>Hello <span>world</span>…</p><div>Next line</div>"),
        "Hello world...\n\nNext line"
    );
}
