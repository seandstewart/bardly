# Contributing to Bardly

Welcome! If you're here, it's because you'd like to figure
out how to contribute to Bardly. Thank you!

## Overview

Bardly is a static site generated completely from Markdown
using Material for MkDocs. The goal of Bardly is to
provide the most accessible, complete, free resource for
Shakespeare's plays.

## Getting Started (For Non-Developers)

Just because you're not a software developer doesn't mean
you can't contribute! We welcome your work.

Things you'll need to get started:

- A [Github](https://github.com) account (don't worry,
  it's free!).
- [Github Desktop](https://desktop.github.com/) (or any
  other git-workflow UI).
- A good Markdown Editor (we recommend
  [Typora](https://typora.io/), but any will do).

If you've never used GitHub/git before, we recommend
following
[this guide](https://guides.github.com/activities/hello-world/)
to before moving forward.


## Getting Started (For Developers)

Things you'll need to get started:

- [Python 3.7](https://www.python.org/downloads/).
  [Pyenv](https://github.com/pyenv/pyenv) is highly
  recommended for managing your Python installations.
- [Poetry](https://python-poetry.org) for installing &
  managing dependencies.

Once you're set up, fork & clone the repo, then run
`poetry install` in the project directory.

To preview changes, run `mkdocs build (--dirty)` and run
the resulting `site/index.html` file in your browser.

Rendering the documentation is a bit too slow to be used
effectively with `mkdocs serve`.


## Making Your First Contribution

If you're not an official contributor to Bardly, follow
[this guide](https://guides.github.com/activities/forking/)
in order to create a fork of the repository, make your
change, then submit a pull request of any changes you
make.

## Updating a Play

There are some guidelines when updating a play:

Line Formatting:

1. Act headers should all be **H2**. (`## `)
2. Scene headers should all be **H3**. (`### `)
3. Character names preceding spoken word should all be
   **bolded**. (`**Character Name**`)
4. Stage directions should all be *italicized*. (`*Flourish*`)
5. Character actions should be *\[between brackets and
   italicized]*. (`*\[Aside]*`)

Paragraph Formatting:

1. All text within the same paragraph should have a
   double-space at the end of every line. (`  `)
2. Stage directions should always be in their own paragraph.
3. Character actions should be attached to either the
   preceding paragraph or begin the next paragraph.

Additional Tokens:

1. If a line is spoken by two or more characters, this can
   be denoted with an `&`. (`**Rosencrantz & Guildenstern**`)
2. If a line is shared between multiple paragraphs, this
   is denoted by a series of ` ... ` following and
   preceding the given lines.

For examples of these rules, see our
[source documents](https://github.com/seandstewart/bardly/tree/master/bardly/plays).
