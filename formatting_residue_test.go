package formattingresidue

import "testing"

func TestCleanFormattingResidue(t *testing.T) {
	got := CleanFormattingResidue("<p>Hello <span>world</span>…</p><div>Next line</div>")
	want := "Hello world...\n\nNext line"
	if got != want {
		t.Fatalf("CleanFormattingResidue() = %q, want %q", got, want)
	}
}
