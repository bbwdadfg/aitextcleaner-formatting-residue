const assert = require("node:assert/strict");
const { cleanFormattingResidue } = require("./index.js");

assert.equal(
  cleanFormattingResidue("<p>Hello <span>world</span>…</p><div>Next line</div>"),
  "Hello world...\n\nNext line",
);
assert.throws(() => cleanFormattingResidue(null), TypeError);
