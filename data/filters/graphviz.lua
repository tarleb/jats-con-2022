function CodeBlock (elem)
  if elem.classes[1] == "dot" and
    elem.classes[2] == "process" then
    local img = pandoc.pipe("dot", {"-Tsvg"}, elem.text)
    local filename = pandoc.sha1(img) .. ".svg"
    local image_title = {pandoc.Str "dot graph"}
    local attr = pandoc.Attr{}
    pandoc.mediabag.insert(filename, "image/svg+xml", img)
    return pandoc.Para {pandoc.Image(image_title, filename, "", attr)}
  end
end
