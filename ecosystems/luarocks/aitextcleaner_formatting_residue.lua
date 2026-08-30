local block_tags = {
  address = true, article = true, blockquote = true, br = true, div = true,
  li = true, p = true, pre = true, section = true,
}

local function decode_entities(value)
  local entities = {amp = "&", apos = "'", gt = ">", lt = "<", nbsp = " ", quot = '"'}
  return (value:gsub("&([%a]+);", function(entity)
    return entities[entity:lower()] or "&" .. entity .. ";"
  end):gsub("&#39;", "'"):gsub("&#x27;", "'"))
end

local function clean(text)
  assert(type(text) == "string", "text must be a string")
  local cleaned = text:gsub("<[^>]*>", function(tag)
    local name = tag:match("^<%s*/?%s*([%a][%w-]*)")
    if name and block_tags[name:lower()] then return "\n" end
    return ""
  end)
  cleaned = decode_entities(cleaned)
  cleaned = cleaned:gsub("“", '"'):gsub("”", '"'):gsub("‘", "'"):gsub("’", "'")
    :gsub("–", "-"):gsub("—", "-"):gsub("…", "...")
    :gsub("[ \t]+\n", "\n"):gsub("\n\n\n+", "\n\n")
  return cleaned:match("^%s*(.-)%s*$") or ""
end

return {clean = clean}
