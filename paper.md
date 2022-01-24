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

Pellentesque dapibus suscipit ligula. Donec posuere augue in quam.
Etiam vel tortor sodales tellus ultricies commodo. Suspendisse
potenti. Aenean in sem ac leo mollis blandit. Donec neque quam,
dignissim in, mollis nec, sagittis eu, wisi. Phasellus lacus. Etiam
laoreet quam sed arcu. Phasellus at dui in ligula mollis ultricies.
Integer placerat tristique nisl. Praesent augue. Fusce commodo.
Vestibulum convallis, lorem a tempus semper, dui dui euismod elit,
vitae placerat urna tortor vitae lacus. Nullam libero mauris,
consequat quis, varius et, dictum id, arcu. Mauris mollis tincidunt
felis. Aliquam feugiat tellus ut neque. Nulla facilisis, risus a
rhoncus fermentum, tellus tellus lacinia purus, et dictum nunc justo
sit amet elit.

Pellentesque dapibus suscipit ligula. Donec posuere augue in quam.
Etiam vel tortor sodales tellus ultricies commodo. Suspendisse
potenti. Aenean in sem ac leo mollis blandit. Donec neque quam,
dignissim in, mollis nec, sagittis eu, wisi. Phasellus lacus. Etiam
laoreet quam sed arcu. Phasellus at dui in ligula mollis ultricies.
Integer placerat tristique nisl. Praesent augue. Fusce commodo.
Vestibulum convallis, lorem a tempus semper, dui dui euismod elit,
vitae placerat urna tortor vitae lacus. Nullam libero mauris,
consequat quis, varius et, dictum id, arcu. Mauris mollis tincidunt
felis. Aliquam feugiat tellus ut neque. Nulla facilisis, risus a
rhoncus fermentum, tellus tellus lacinia purus, et dictum nunc justo
sit amet elit.
