
# Imports
import os

from beet import ProjectConfig, load_config, locate_config
from stouputils.io import get_root_path

# Try to find and load the beet configuration file
cfg: ProjectConfig | None = None
if config_path := locate_config(os.getcwd(), parents=True):
	cfg = load_config(filename=config_path)
	if cfg:
		os.chdir(config_path.parent)
if not cfg:
	print(f"No beet config file found in the current directory '{os.getcwd()}'")

# Constants
ROOT: str = get_root_path(__file__, go_up=1)
SUMMARY: str = "Minecraft datapack library for handling custom furnace recipes with advanced NBT / component support!"

DESCRIPTION_MARKDOWN: str = ""
if os.path.exists(f"{ROOT}/README.md"):
	with open(f"{ROOT}/README.md", encoding="utf-8") as file:
		DESCRIPTION_MARKDOWN = file.read()
else:
	print("README.md not found, description_markdown will be empty")

# Dependencies (list of modrinth slugs)
DEPENDENCIES: list[dict] = []

# Version type (release, beta, alpha)
VERSION_TYPE: str = "release"

# Configuration
modrinth_config: dict = {
	"slug": cfg.id,
	"project_name": cfg.name,
	"version": cfg.version,
	"summary": SUMMARY,
	"description_markdown": DESCRIPTION_MARKDOWN,
	"dependencies": DEPENDENCIES,
	"version_type": VERSION_TYPE,
	"build_folder": cfg.output,
}

