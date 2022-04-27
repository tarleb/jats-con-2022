---
title: JATS from Markdown
subtitle: Developer friendly single-source scholarly publishing
author: Albert Krewinkel, Juanjo Bazán, Arfon Smith
date: May 3, 2022
---

# Single-Source Publishing

## Why

- Single source of truth
- Corrections are simpler
- ...

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

# End

## Thanks

JOSS
:   [joss.theoj.org](https://joss.theoj.org/)

JOSS Sources
:   [github.com/openjournals](https://github.com/openjournals/)

pandoc
:   [pandoc.org](https://pandoc.org/)

::: notes

- Add more notes here.

:::
