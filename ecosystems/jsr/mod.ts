const BLOCK_TAG = /<\/?(?:address|article|blockquote|br|div|li|p|pre|section)\b[^>]*>/gi;
const HTML_TAG = /<[^>]*>/g;

function decodeEntities(value: string): string {
  return value.replace(/&(#x?[0-9a-f]+|amp|apos|gt|lt|nbsp|quot);/gi, (match, entity: string) => {
    const key = entity.toLowerCase();
    if (key.startsWith("#x")) return String.fromCodePoint(Number.parseInt(key.slice(2), 16));
    if (key.startsWith("#")) return String.fromCodePoint(Number.parseInt(key.slice(1), 10));
    return ({ amp: "&", apos: "'", gt: ">", lt: "<", nbsp: " ", quot: '"' } as Record<string, string>)[key] ?? match;
  });
}

export function cleanFormattingResidue(text: string): string {
  if (typeof text !== "string") throw new TypeError("text must be a string");
  return decodeEntities(text.replace(BLOCK_TAG, "\n").replace(HTML_TAG, ""))
    .replace(/[“”‘’–—…]/g, (character) => ({
      "“": '"', "”": '"', "‘": "'", "’": "'", "–": "-", "—": "-", "…": "...",
    }[character] ?? character))
    .replace(/[ \t]+\n/g, "\n")
    .replace(/\n{3,}/g, "\n\n")
    .trim();
}
