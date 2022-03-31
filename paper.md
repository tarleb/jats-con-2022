---
title: JATS from Markdown
subtitle: developer friendly single-source scholarly publishing
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
  statement: Published under CC-BY-SA.
  year: 2022
  holder: The authors
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

# Submission and Acceptance Process

1. Authors open an issue on GitHub
2. A preview article proof is generated automatically
3. Reviewers inspect both the software source code and the paper.
4. If the article is accepted, then the publishing pipeline is
   invoked with all necessary metadata. The paper is published on
   the journal website within minutes of acceptance.

# Markup Tagging

In this section we demonstrate common conversions.

## Emphasis Markup

The markup in Markdown in supposed to be semantic, not
presentational. The table below gives a small example.

| Markup          | Markdown   | JATS                    |
|-----------------|------------|-------------------------|
| Emphasis        | `*this*`   | `<italic>this</italic>` |
| Strong emphasis | `**that**` | `<bold>that</bold>`     |
| Superscript     | `H~2~O`    | `H<sub>2</sub>O`        |
| Subscript       | `Ca^2+^`   | `Ca<sup>2+</sup>`       |

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

Note that the XML includes both the raw TeX markup as well as the
MathML representation.

<!--
Maybe this one is nicer?
$\int_{-\infty}^{+\infty} e^{-x^2} \, dx$
-->

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

# Challenges

Differences between JATS and pandoc's internal document model.

| component | pandoc     | jats                       |
|-----------|------------|----------------------------|
| math      | any inline | not named contents, target |
|           |            |                            |

# Metadata

We convert to pandoc's metadata schema for JATS output
(<https://pandoc.org/jats>).

# Other Output Formats

PDF is generated directly from the Markdown input, as is Crossref
XML. It would be possible to also publish an HTML version of the
articles, but this remains future work.
