
# Imports
import os

from beet import ProjectConfig, load_config, locate_config

# Try to find and load the beet configuration file
cfg: ProjectConfig | None = None
if config_path := locate_config(os.getcwd(), parents=True):
	cfg = load_config(filename=config_path)
	if cfg:
		os.chdir(config_path.parent)
if not cfg:
	print(f"No beet config file found in the current directory '{os.getcwd()}'")

# Configuration
github_config: dict = {
	"project_name": cfg.name,
	"version": cfg.version,
	"build_folder": cfg.output,
	"endswith": [".zip"]
}

