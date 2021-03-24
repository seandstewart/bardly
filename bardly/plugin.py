import pathlib
from concurrent.futures import ProcessPoolExecutor

from iambic import parse, render
from mkdocs.plugins import BasePlugin
from mkdocs.structure.files import File, Files
from mkdocs.config import Config
from mkdocs.structure.pages import Page


class IambicPlugin(BasePlugin):

    _rendered = {}

    @staticmethod
    def _process_file(file: File):
        if file.name in {"uncut", "12-player", "12-player-alt", "11-player"}:
            text = pathlib.Path(file.abs_src_path).read_text()
            play = parse.text(text)
            return file.abs_src_path, render.markdown(play)
        return file.abs_src_path, None

    def on_files(self, files: Files, config: Config):
        with ProcessPoolExecutor(10) as pool:
            self._rendered = {
                path: md
                for path, md in pool.map(self._process_file, files)
                if md
            }

    def on_page_read_source(self, page: Page, config: Config):
        file: File = page.file
        return self._rendered.get(file.abs_src_path)
