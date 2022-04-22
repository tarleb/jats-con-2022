---
title: JATS from Markdown
subtitle: Developer friendly single-source scholarly publishing
author: Albert Krewinkel, Juanjo Bazán, Arfon Smith
#  - Albert Krewinkel
#  - Juanjo Bazán
#  - Arfon Smith
date: May 3, 2022
---

# Single-Source Publishing

## Why

- Single source of truth
- Corrections are simpler
- ...

# Markdown

## Examples

| Markup          | Markdown   | JATS                    | Result   |
|-----------------|------------|-------------------------|----------|
| Emphasis        | `*this*`   | `<italic>this</italic>` | *this*   |
| Strong emphasis | `**that**` | `<bold>that</bold>`     | **that** |
| Superscript     | `H~2~O`    | `H<sub>2</sub>O`        | H~2~0    |
| Subscript       | `Ca^2+^`   | `Ca<sup>2+</sup>`       | Ca^2+^   |

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
