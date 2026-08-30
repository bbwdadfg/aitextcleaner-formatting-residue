package formattingresidue

import (
	"html"
	"regexp"
	"strings"
)

var (
	blockTag = regexp.MustCompile(`(?i)<\/?(?:address|article|blockquote|br|div|li|p|pre|section)\b[^>]*>`)
	htmlTag  = regexp.MustCompile(`<[^>]*>`)
	spaceNL  = regexp.MustCompile(`[ \t]+\n`)
	manyNL   = regexp.MustCompile(`\n{3,}`)
)

func CleanFormattingResidue(text string) string {
	cleaned := blockTag.ReplaceAllString(text, "\n")
	cleaned = htmlTag.ReplaceAllString(cleaned, "")
	cleaned = html.UnescapeString(cleaned)
	cleaned = strings.NewReplacer(
		"“", `"`, "”", `"`, "‘", "'", "’", "'", "–", "-", "—", "-", "…", "...",
	).Replace(cleaned)
	cleaned = spaceNL.ReplaceAllString(cleaned, "\n")
	cleaned = manyNL.ReplaceAllString(cleaned, "\n\n")
	return strings.TrimSpace(cleaned)
}
