--[[
abstract-to-meta – move an "abstract" section into document metadata

Copyright: © 2017–2022 Albert Krewinkel
]]
local abstract = pandoc.List{}

--- Extract abstract from a list of blocks.
local function abstract_from_blocklist (blocks)
  local body_blocks = pandoc.List{}
  local looking_at_abstract = false

  for _, b in ipairs(blocks) do
    if b.t == 'Header' and b.level == 1 then
      looking_at_abstract = b.identifier == 'abstract'
      if looking_at_abstract then goto continue end
    else
      looking_at_abstract = looking_at_abstract and b.t ~= 'HorizontalRule'
    end
    (looking_at_abstract and abstract or body_blocks):insert(b)
    ::continue::
  end

  return body_blocks
end

return {{
    Pandoc = function (doc)
      doc.blocks = abstract_from_blocklist(doc.blocks)
      doc.meta.abstract = pandoc.MetaBlocks(abstract)
      return doc
    end
}}
