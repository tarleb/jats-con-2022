---
title: JATS from Markdown
subtitle: Developer friendly single-source scholarly publishing
author: Albert Krewinkel, Juanjo Bazán, Arfon Smith
date: May 3, 2022
---

# Single-Source Publishing

- - -

::::: columns

::: column
### What?

Produce all publishing artifacts from a single source document.
:::

::: column
### Why?
- Single source of truth.
- Corrections are easy
- Producing article proofs is quick and simple
:::

:::::

## Journal of Open Source Software

### 👨‍💻🖺🖹🖻👩‍💻

# Markdown to JATS

## Architecture

``` {.dot .process}
digraph workflow {
  bgcolor="transparent"
  metadata [shape=record, style=solid, label="Journal Metadata"];
  resources [
    shape=record,
    style=solid,
    label="{Paper|{<f0>Markdown|<f1>images |<f2>bibliography}}"];
  configs [shape=record, style=solid,
          label="{configs|{<f0>CSL |<f1>template}}"];

  resources -> pandoc;
  metadata -> pandoc;
  configs -> pandoc;
  pandoc -> pandoc [label=filters];
  pandoc -> PDF;
  pandoc -> JATS;
  pandoc -> "Crossref XML";
}
```

## Markdown

| Markdown   | JATS                    | Result   |
|------------|-------------------------|----------|
| `*this*`   | `<italic>this</italic>` | *this*   |
| `**that**` | `<bold>that</bold>`     | **that** |
| `H~2~O`    | `H<sub>2</sub>O`        | H~2~O    |
| `Ca^2+^`   | `Ca<sup>2+</sup>`       | Ca^2+^   |

## pandoc

- Universal document converter;
- designed for paper writing;
- allows flexible document conversion.

## Tables

``` markdown
| a | b |
|---|---|
| 1 | 2 |
| 3 | 4 |
```

``` xml
<table-wrap>
  <table>
    <thead>
      <tr><th>a</th><th>b</th></tr>
    </thead>
    <tbody>
      <tr><td>1</td><td>2</td></tr>
      <tr><td>3</td><td>4</td></tr>
    </tbody>
  </table>
</table-wrap>
```

## Formulæ

$$\int_{-\infty}^{+\infty} e^{-x^2} \, dx$$

`$$\int_{-\infty}^{+\infty} e^{-x^2} \, dx$$`{.markdown style="font-size:75%"}


``` xml
<disp-formula>
  <alternatives>
    <tex-math>
<![CDATA[\int_{-\infty}^{+\infty} e^{-x^2} \, dx]]>
    </tex-math>
    <mml:math display="block"
    xmlns:mml="http://www.w3.org/1998/Math/MathML">
    <!-- omitted -->
    </mml:math>
  </alternatives>
</disp-formula>
```

## Citations

::::: columns
::: column
```{.bibtex style="font-size:60%"}
@article {Upper1974,
  author = {Upper, Dennis},
  title = {The unsuccessful self-treatment of
           a case of “writer's block”},
  journal = {Journal of Applied Behavior Analysis},
  volume = {7},
  number = {3},
  publisher = {Blackwell Publishing Ltd},
  issn = {1938-3703},
  doi = {10.1901/jaba.1974.7-497a},
  pages = {497--497},
  year = {1974},
}
```
:::
::: column

```markdown
For a case study on writers
block, see @Upper1974
```
:::
:::::

``` {.xml style="font-size:90%"}
For a case study on writers block, see Upper
(<xref alt="1974" rid="ref-Upper1974" ref-type="bibr">1974</xref>)
```


## References

``` {.xml style="font-size:80%"}
<ref id="ref-Upper1974">
  <element-citation publication-type="article-journal">
    <person-group person-group-type="author">
      <name><surname>Upper</surname><given-names>Dennis</given-names></name>
    </person-group>
    <article-title>The unsuccessful self-treatment of a case of
      “writer’s block”</article-title>
    <source>Journal of Applied Behavior Analysis</source>
    <publisher-name>Blackwell Publishing Ltd</publisher-name>
    <year iso-8601-date="1974">1974</year>
    <volume>7</volume>
    <issue>3</issue>
    <issn>1938-3703</issn>
    <pub-id pub-id-type="doi">10.1901/jaba.1974.7-497a</pub-id>
    <fpage>497</fpage>
    <lpage>497</lpage>
  </element-citation>
</ref>
```

# Metadata

## Authors & Affiliations

``` yaml
---
authors:
  - name: John Doe
    orcid: 0000-1234-5678-901X
    affiliation: 1

affiliations:
  - name: Federation of Planets
    index: 1
---
```

::: notes
The structure is historical. There are alternatives
:::

## Given Names / Surname

> Jane Von Doe III

> Ludwig van Beethoven

## Destructured Names

::::: columns
::: {.column}
``` yaml
authors:
  - name:
      given-names: Jane
      surname: Von Doe

  - name:
      given-names: Ludwig
      dropping-particle: van
      surname: Beethoven
```
:::

::: {.column}
```xml
<contrib contrib-type="author">
  <name>
    <surname>Von Doe</surname>
    <given-names><!--
    -->Jane</given-names>
  </name>
</contrib>
<contrib contrib-type="author">
  <name>
    <surname>Beethoven</surname>
    <given-names><!--
    -->Ludwig van</given-names>
  </name>
</contrib>
```
:::

:::::

::: notes
The structure is a mixture of JATS and CSL.

For East Asian names see [here](#non-western-names)
:::

## Keywords

``` yaml
tags:
  - space
  - scify
```

## Generated

::::: columns
::: column
- issue, volume, page №
- DOI
- software archive DOI
- submission & publishing dates
:::
::: column
- editor
- reviewers
- article URLs
:::
:::::

::: notes
The format converter is stateless, all article info must be fed in
via metadata.
:::


# Pipeline

## Architecture

``` {.dot .process}
digraph workflow {
  bgcolor="transparent"
  metadata [shape=record, style=solid, label="Journal Metadata"];
  resources [
    shape=record,
    style=solid,
    label="{Paper|{<f0>Markdown|<f1>images |<f2>bibliography}}"];
  configs [shape=record, style=solid,
          label="{configs|{<f0>CSL |<f1>template}}"];

  resources -> pandoc;
  metadata -> pandoc;
  configs -> pandoc;
  pandoc -> pandoc [label=filters];
  pandoc -> PDF;
  pandoc -> JATS;
  pandoc -> "Crossref XML";
}
```

## Filters

- Parse embedded LaTeX,
- process author names,
- link author affiliations,
- set authors' `cor-id`,
- add timestamps,
- etc.

::: notes
The `cor-id` is set for corresponding authors. It is required to
link an author to the correspondence info.
:::

## Containerization

``` sh
docker run --rm -it \
    -v $PWD:/data \
    -u $(id -u):$(id -g) \
    openjournals/inara \
    -o pdf,crossref \
    path/relative/to/current/directory/paper.md
```


# Future

- Alternative inputs
    - reStructuredText
    - Quarto

- JATS as intermediary format

- Allow easy reuse

::: notes
Other interesting inputs:
- Word Docx
- Jupyter Notebooks

Using JATS as intermediate format will require all information to
be tagged and included. Missing or incomplete:

- name alternatives,
- bibliography.

:::


# Thanks

## Links

JOSS
:   [joss.theoj.org](https://joss.theoj.org/)

Inara
:   [github.com/openjournals/inara](https://github.com/openjournals/inara)

JOSS Sources
:   [github.com/openjournals](https://github.com/openjournals/)

pandoc
:   [pandoc.org](https://pandoc.org/)

Article & slides
:   [github.com/tarleb/jats-con-2022](https://github.com/tarleb/jats-con-2022)

::: notes

- Add more notes here.

:::

# Appendix

## Non-western names

::::: columns
::: {.column}
``` yaml
authors:
  - name:
      literal: 立花 瀧
      given-names: 瀧
      surname: 立花
```
:::

::: {.column}
```xml
<contrib contrib-type="author">
  <name>
    <surname>立花</surname>
    <given-names>瀧</given-names>
  </name>
</contrib>
```
:::

:::::

::: notes
立花 瀧 is pronounced "Taki Tachibana".

For Western names, see [Destructured Names]
:::

## Filter example

``` lua
function Meta (meta)
  meta.timestamp = os.date('%Y%m%d%H%M%S')
  return meta
end
```

## Formats

::::: columns
::: {.column width=48%}
### Input

- Markdown,
- reStructuredText,
- Jupyter notebooks,
- Word Docx,
- LaTeX,
- JATS,
- and 30+ more.
:::

::: {.column width=48%}
### Output
- JATS,
- LaTeX,
- EPUB,
- HTML,
- and 50+ more.
:::
:::::


<!--
Bring architecture slide in the beginning
-->
