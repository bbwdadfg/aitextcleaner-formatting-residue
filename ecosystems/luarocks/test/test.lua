package.path = "../?.lua;" .. package.path
local residue = require("aitextcleaner_formatting_residue")

local actual = residue.clean("<p>Hello <span>world</span>…</p><div>Next line</div>")
assert(actual == "Hello world...\n\nNext line", actual)
