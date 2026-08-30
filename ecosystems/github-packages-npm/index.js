"use strict";

const BLOCK_TAG = /<\/?(?:address|article|blockquote|br|div|li|p|pre|section)\b[^>]*>/gi;
const HTML_TAG = /<[^>]*>/g;
const ENTITIES = {
  amp: "&",
  apos: "'",
  gt: ">",
  lt: "<",
  nbsp: " ",
  quot: '"',
};

function decodeEntities(value) {
  return value
    .replace(/&(#x?[0-9a-f]+|amp|apos|gt|lt|nbsp|quot);/gi, (match, entity) => {
      const key = entity.toLowerCase();
      if (key.startsWith("#x")) return String.fromCodePoint(Number.parseInt(key.slice(2), 16));
      if (key.startsWith("#")) return String.fromCodePoint(Number.parseInt(key.slice(1), 10));
      return ENTITIES[key] ?? match;
    });
}

function cleanFormattingResidue(text) {
  if (typeof text !== "string") throw new TypeError("text must be a string");
  let cleaned = text.replace(BLOCK_TAG, "\n").replace(HTML_TAG, "");
  cleaned = decodeEntities(cleaned).replace(/[“”‘’–—…]/g, (character) => ({
    "“": '"', "”": '"', "‘": "'", "’": "'", "–": "-", "—": "-", "…": "...",
  })[character])
    .replace(/[ \t]+\n/g, "\n")
    .replace(/\n{3,}/g, "\n\n");
  return cleaned.trim();
}

module.exports = { cleanFormattingResidue };
