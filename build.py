import logging
import sys

from mkdocs.config import load_config
from mkdocs.commands import build


if __name__ == '__main__':
    logging.basicConfig(
        stream=sys.stdout,
        format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
        level=0
    )
    build.build(load_config())
