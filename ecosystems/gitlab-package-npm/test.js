const assert = require("node:assert/strict");
const { cleanFormattingResidue } = require("./index.js");

assert.equal(cleanFormattingResidue("<p>draft</p>"), "draft");
