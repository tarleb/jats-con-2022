function Meta (meta)
  for i, author in ipairs(meta.author) do
    meta.author[i] = author.name
  end
  return meta
end
