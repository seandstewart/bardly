import pathlib

from iambic import parse, render
from mkdocs.plugins import BasePlugin
from mkdocs.structure.files import File
from mkdocs.config import Config
from mkdocs.structure.pages import Page


class IambicPlugin(BasePlugin):
    def on_page_read_source(self, page: Page, config: Config):
        file: File = page.file
        if file.name in {"uncut", "12-player", "12-player-alt", "11-player"}:
            text = pathlib.Path(file.abs_src_path).read_text()
            play = parse.text(text)
            return render.markdown(play)
