---
title: JATS from Markdown
subtitle: Developer friendly single-source scholarly publishing
author:
- name: Albert Krewinkel
  email: albert@zeitkraut.de
  orcid: 0000-0002-9455-0796
  affiliation:
  - id: 1
    organization: Open Journals
- name: Juanjo Bazán
  orcid: 0000-0001-7699-3983
  affiliation:
  - id: 2
    organization: Open Journals
- name: Arfon Smith
  orcid: 0000-0002-3957-2474
  affiliation:
  - id: 4
    organization: Open Journals
  - id: 3
    organization: GitHub
    country: USA
    country-code: US
copyright:
  statement: >-
    © 2022 The authors. Published under a CC BY-SA 4.0 license.
  year: 2022
  holder: Albert Krewinkel, Juanjo Bazán, Arfon Smith
license:
  - text: >-
      This work is licensed under a Creative Commons
      Attribution-ShareAlike 4.0 International License.
    type: open-access
    link: 'https://creativecommons.org/licenses/by-sa/4.0/'
  - >-
      The copyright holder grants the U.S. National Library of Medicine
      permission to archive and post a copy of this paper on the Journal
      Article Tag Suite Conference proceedings website.


bibliography: paper.bib
---

# Abstract

Research software has become an integral part of doing science in
many disciplines. As a consequence, it is becoming increasingly
important to publish. The Journal of Open Source Software (JOSS)
is a developer friendly, open access journal for research software
packages. Article authors are generally comfortable with tools
commonly used by software developers. The JOSS production pipeline
is considerate of this, supporting submissions to be written in
Markdown, a lightweight markup-language.

Here we present the single-source publishing pipeline developed
for JOSS,
especially the conversion of articles authored in Markdown into
PDF and XML formats, including JATS. We describe how we built on
and extended the document converter "pandoc", how metadata is
processed and integrated into the publishing artifacts, and which
advantages and challenges we see in enriching plain-text inputs
into structured documents.

# Introduction

The Journal of Open Source Software, created in May 2016, has the
dual goals of "improving the quality of the software submitted and
providing a mechanism for research software developers to receive
credit".[@smith2018]

We developed a publishing system to go from Markdown to JATS in a
mostly automatic fashion.

The system follows the general idea of using Markdown as the
central format of a document production system, which has been
described previously [@krewinkel2017].

The idea of using Markdown to produce JATS output has been
described previously[@johnston2016jatdown]; our method differs in
that we consider JATS not as an intermediary format, but as the
normalized exchange format for articles. The source for all output
formats remains the author-generated Markdown file.

# Background

JOSS is a developer-focused journal.

## JOSS review process

1. Authors open an issue on GitHub
2. A preview article proof is generated automatically
3. Reviewers inspect both the software source code and the paper.
4. If the article is accepted, then the publishing pipeline is
   invoked with all necessary metadata. The paper is published on
   the journal website within minutes of acceptance.

# Markup Conversion

## Text

In this section we demonstrate common conversions.

## Emphasis Markup

The markup in Markdown in supposed to be semantic, not
presentational. The table below gives a small example.

| Markup          | Markdown   | JATS                    | Result   |
|-----------------|------------|-------------------------|----------|
| Emphasis        | `*this*`   | `<italic>this</italic>` | *this*   |
| Strong emphasis | `**that**` | `<bold>that</bold>`     | **that** |
| Superscript     | `H~2~O`    | `H<sub>2</sub>O`        | H~2~0    |
| Subscript       | `Ca^2+^`   | `Ca<sup>2+</sup>`       | Ca^2+^   |

## Mathematical Formulæ

Markdown allows the inclusion of mathematical formulæ using TeX
notation, where the math is delimited by single dollar `$`
characters for inline math, and double `$$` characters for display
math. A formula like $a^2 + b^2 = c^2$ is rendered as

``` xml
<inline-formula>
  <alternatives>
    <tex-math>
<![CDATA[a^2 + b^2 = c^2]]>
    </tex-math>
    <mml:math display="inline"
    xmlns:mml="http://www.w3.org/1998/Math/MathML">
      <mml:mrow>
        <mml:msup>
          <mml:mi>a</mml:mi>
          <mml:mn>2</mml:mn>
        </mml:msup>
        <mml:mo>+</mml:mo>
        <mml:msup>
          <mml:mi>b</mml:mi>
          <mml:mn>2</mml:mn>
        </mml:msup>
        <mml:mo>=</mml:mo>
        <mml:msup>
          <mml:mi>c</mml:mi>
          <mml:mn>2</mml:mn>
        </mml:msup>
      </mml:mrow>
    </mml:math>
  </alternatives>
</inline-formula>
```

Whitespace and indentations are not as in the generated output but
were added for readability.

Note that the XML includes both the raw TeX markup as well as the
MathML representation.

<!--
Maybe this one is nicer?
$\int_{-\infty}^{+\infty} e^{-x^2} \, dx$
-->

## Code listings

There are multiple ways in which code blocks can be written in
Markdown. The most frequently used syntax delimits the code by
three backticks on a separate line, where the programming language
can optionally be given on the opening line.

````` markdown
``` html
<h1>HTML heading</h1>
```
`````

Code blocks are put into `<code>` elements. If the language is
unknown, then `<preformat>` is used instead. No syntax
highlighting is done when targeting JATS.

## Figures

Pandoc currently uses *implicit figures*, i.e., paragraphs that
contain only an image are treated as figures.

``` markdown
![The figure caption](image-path.jpg)
```

``` xml
<fig>
  <caption><p>The figure caption</p></caption>
  <graphic mimetype="image" mime-subtype="jpeg"
           xlink:href="image-path.jpg" xlink:title="" />
</fig>
```

Linebreaks added for readability.

## Tables

The most common way to write tables are so-called "pipe tables",
named in reference to the pipe character `|` being used as column
separator.

``` markdown
: Table caption

| Item | Name |
|------|------|
| 1    | Fork |
| 2    | Glas |
```

As demonstrated above, a caption for the table can be added by
prefixing a line before the table with a colon `:`.

``` xml
<table-wrap>
  <caption>
    <p>Table caption</p>
  </caption>
  <table>
    <thead>
      <tr>
        <th>Item</th>
        <th>Name</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>1</td>
        <td>Fork</td>
      </tr>
      <tr>
        <td>2</td>
        <td>Glas</td>
      </tr>
    </tbody>
  </table>
</table-wrap>
```

More complex tables, e.g. with cells spanning multiple columns or
rows, can currently not be represented in Markdown syntax.
However, Markdown, due in part to its origins as a blogging tool,
allows to embed raw HTML. Pandoc can be configured to parse these
snippets, so it would be possible to fall back to HTML when
necessary.

## References

BibTeX, and the advanced reimplementation BibLaTeX, are popular
reference management systems. The `.bib` text files used by these
tools can be regarded as a kind of *lingua franca* of reference
handling, as most systems can read and write the format. Due to
this familiarity to most authors, and as pandoc has full support
for bib files, these the preferred source for bibliography
generation.

Pandoc uses the Citation Style Language (CSL) to style citations
as well as the bibliography. By default, `<mixed-citation>`
elements are used and filled with plain (untagged) text that is
formatted according to the requirements of the current CSL.

For JOSS, however, we chose to use the alternative
`<element-citation>` elements, which can be enabled via an pandoc
option. This allows round-trips from bib to JATS and back, should
it ever be necessary.

# Adjustments

The conversion process by stock pandoc is not always sufficient
for a satisfactory XML output. E.g., many authors are used to
writing LaTeX, and include raw LaTeX snippets in the Markdown
input. These snippets will be used when producing PDF output, but
do not show up in other output formats. The most common use of
such snippets is for document-internal cross-references.

Pandoc offers a feature called "Lua filters" that allows to modify
the abstract document tree programmatically. We made heavy use of
Lua filters to improve and shape the conversion process.

## LaTeX code for cross-references

We automatically check the document for raw LaTeX code relevant to
cross-references. Pandoc's LaTeX parser is used to process these
snippets.

Example code:

``` lua
-- Function called on all raw inline snippets.
RawInline = function (raw)
  -- Do nothing if the snippet does not contain TeX code.
  if not raw.format == 'tex' then
    return nil
  end

  -- Check if code is related to cross-references.
  -- If it is, then parse the snippet as LaTeX and
  -- use the parse-result to replace the snippet
  -- in the document structure.
  local is_ref_or_label = raw.text:match '^\\ref%{'
    or raw.text:match '^\\autoref'
    or raw.text:match '^\\label%{.*%}$'
  if is_ref_or_label then
    local first = pandoc.read(raw.text, 'latex').blocks[1]
    return first and first.content or nil
  end

  -- Otherwise do nothing.
  return nil
end
```

The actual numbering of equations and tables is done in the filter
as well.

## Metadata

We convert to pandoc's metadata schema for JATS output
(<https://pandoc.org/jats>).


# Advantages

The pipeline if well suited for a journal like JOSS, reducing
human involvement in the publishing process to a minimum.

## Additionl Output Formats

PDF is generated directly from the Markdown input, as is Crossref
XML. It would be possible to also publish an HTML version of the
articles, but this remains future work.

## Flexibility

Pandoc is flexible and scriptable, making is possible to adjust to
future changes and requirements.

# Future Work

- Generalizing the pipeline to make it usable by other journals.
- Allow for alternative plain-text input formats like
  org[@Dominik2010] or reStructuredText[@reStructuredText].
- Support for reproducible research articles using quarto, jupyter
  notebooks, or the like.

## Challenges

Differences between JATS and pandoc's internal document model.

| component | pandoc     | jats                       |
|-----------|------------|----------------------------|
| math      | any inline | not named contents, target |
|           |            |                            |
