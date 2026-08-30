package = "aitextcleaner-formatting-residue"
version = "0.2.0-1"
source = {
   url = "https://aitextcleaner.pro/"
}
description = {
   summary = "Local formatting-residue cleanup helper for copied text.",
   homepage = "https://aitextcleaner.pro/",
   license = "MIT"
}
dependencies = {"lua >= 5.1"}
build = {
   type = "builtin",
   modules = {
      aitextcleaner_formatting_residue = "aitextcleaner_formatting_residue.lua"
   }
}
