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

## Updating a Version of a Play

### Style Guide

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
   double-space at the end of every line-break which
   should be represented in the final render. (`  `)
2. Stage directions should always be in their own
   paragraph.
3. Character actions should be attached to either the
   preceding paragraph or begin the next paragraph.
4. Max line-length should be *about* 60 characters.
   - Overflow is acceptable in metered speech and headers.
   - Prose should be broken into paragraph blocks.
   - Stage directions should have a hard-wrap, but no
     double-space. (This keeps the text readable when
     un-rendered.)

Additional Tokens:

1. If a line is spoken by two or more characters, this can
   be denoted with an `&`. (`**Rosencrantz & Guildenstern**`)
2. If a line is shared between multiple paragraphs, this
   is denoted by a series of ` / ` following and
   preceding the given lines.

For examples of these rules, see our
[source documents](https://github.com/seandstewart/bardly/tree/master/bardly/plays).


### Guide to Auditing

For Bardly, an "audit" is a check for consistency and
compliance to our [Style Guide](#style-guide). Below are
the recommended steps for completing an audit for a given
play.

There are a few different versions of a single play which
may be present in a given directory:

- `unverified.md`
- `uncut.md`
- `12-player-alt.md`
- `12-player.md`
- `11-player.md`

Here are the recommended steps to follow when auditing a
play in the `/pending/` directory:

1. If `unverified.md` is present in the directory, compare
   it to `uncut.md`. If `unverified.md` appears to be more
   compliant than `uncut.md`, delete the existing
   `uncut.md` and replace it with `unverified.md`.
2. Once you've determined the appropriate `uncut.md`
   version, compare it to `11-player.md`. `11-player` is
   the most accurate and compliant version of these plays,
   so can be used as a good baseline.
3. Finally, we're down to `12-player.md` and
   `12-player-alt.md`. There should be no major
   differences between these versions except for a few
   extra gender swaps. Our goal is to reverse those gender
   swaps back to their originals. Since you've already
   validated `uncut.md`, you can use that version to check
   on these. Select the one you think will be the least
   amount of work, and make that the "official"
   `12-player.md`. Then compare it to the `uncut.md`
   you've just verified.
4. Once all this is done, just add the full title to the
   top of the plays (e.g., `# Hamlet - 11 Players`).

## Adding a Genre to the Site

A genre in `/pending/` may be added to the site once all
plays within it have been [audited](#guide-to-auditing).
Once that's done, the directory can be moved to
`/bardly/plays/`. Doing so will officially "publish" this
play on the site once your changes are merged in and a new
build triggered.
