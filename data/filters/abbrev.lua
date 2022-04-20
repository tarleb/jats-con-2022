local abbreviations = {
  HTML = 'Hypertext Markup Language',
  JOSS = 'Journal of Open Source Software',
  PDF = 'Portable Document Format',
  XML = 'Extensible Markup Language',
  YAML = 'Yet Another Markup Language',
}
-- Mark abbreviations
function Str (str)
  local abbrev, punctuation = str.text:match '([A-Z]+)(%p+)'
  if abbrev and abbreviations[abbrev] then
    abbrev_obj = FORMAT:match 'jats'
      and pandoc.RawInline('jats', '<abbrev>' .. abbrev .. '</abbrev>')
      or pandoc.SmallCaps(abbrev)
    return {
      abbrev_obj,
      pandoc.Str(punctuation or '')
    }
  end
end
