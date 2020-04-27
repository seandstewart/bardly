import pathlib
import shutil

import yaml


TARGETS = {
    "0": "uncut.md",
    "1": "12-player.md",
    "2": "12-player-alt.md",
    "3": "11-player.md",
}
SORT = {
    y: int(x) + 1 for x, y in TARGETS.items()
}
SORT["index.md"] = 0

INDEX = """# About the Play

## History

## Characters

## Summary

## Resources

"""


def scaffold_play(path: pathlib.Path):
    nav = {"index.md"}
    ts = {t.rstrip(".md") for t in TARGETS.values()}
    for fpath in path.iterdir():
        if fpath.is_dir():
            target_name = f"{fpath.name}.md" if fpath.name in ts else TARGETS.get(fpath.name)
            if not target_name:
                continue

            target = path / target_name
            if not target.exists():
                for f in fpath.iterdir():
                    if f.suffix == ".md":
                        f.replace(target)
                        break
            nav.add(target_name)

        elif fpath.stem in ts:
            nav.add(fpath.name)

    pages = path / ".pages"
    title = (path / "title").read_text().rstrip("\n")
    nav = sorted(nav, key=lambda x: SORT[x])
    pages.write_text(yaml.dump({"title": title, "arrange": nav},
                               default_flow_style=False))
    index = path / "index.md"
    index.write_text(INDEX)


def scaffold_genre(path: pathlib.Path):
    for fpath in path.iterdir():
        if fpath.is_dir():
            scaffold_play(fpath)


def clean_play(path: pathlib.Path):
    for fpath in path.iterdir():
        if fpath.is_dir():
            shutil.rmtree(str(fpath))
        elif not fpath.suffix and fpath.name not in {".pages", "title"}:
            fpath.unlink()
        elif fpath.name not in SORT and fpath.suffix == ".md":
            text = fpath.read_text()
            uncut = (path / "uncut.md")
            if uncut.exists() and uncut.read_text() == text:
                fpath.unlink()
            else:
                fpath.replace(fpath.parent / "unverified.md")


def clean_genre(path: pathlib.Path):
    for fpath in path.iterdir():
        if fpath.is_dir():
            clean_play(fpath)
