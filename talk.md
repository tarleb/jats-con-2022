---
title: JATS from Markdown
subtitle: Developer friendly single-source scholarly publishing
author: Albert Krewinkel, Juanjo Bazán, Arfon Smith
date: May 3, 2022
---

# Single-Source Publishing

## Why

- Article becomes single source of truth.
- Corrections are easy to do.
- Producing article proofs is quick and easy.

## JOSS walkthrough


# Markdown

## Examples

| Markdown   | JATS                    | Result   |
|------------|-------------------------|----------|
| `*this*`   | `<italic>this</italic>` | *this*   |
| `**that**` | `<bold>that</bold>`     | **that** |
| `H~2~O`    | `H<sub>2</sub>O`        | H~2~O    |
| `Ca^2+^`   | `Ca<sup>2+</sup>`       | Ca^2+^   |

# Conversion

## pandoc

- Universal document converter;
- designed for paper writing;
- allows flexible document conversion.

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

# Implementation

## Containerization

``` sh
docker run --rm -it \
    -v $PWD:/data \
    -u $(id -u):$(id -g) \
    openjournals/inara \
    -o pdf,crossref \
    path/relative/to/current/directory/paper.md
```

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
  pandoc -> HTML;
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

## Filter example

``` lua
function Meta (meta)
  meta.timestamp = os.date('%Y%m%d%H%M%S')
  return meta
end
```


# Future

- Alternative inputs
    - reStructuredText
    - Quarto

- JATS as intermediary format

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
