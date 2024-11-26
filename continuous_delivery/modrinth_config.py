
# Configuration for Modrinth
from config import *

# Constants
SUMMARY: str = """
More Apples is a simple data pack that modifies all leaves loot tables to add twice as many apples as vanilla oak leaves.
"""

DESCRIPTION_MARKDOWN: str = ""
if os.path.exists(f"{ROOT}/README.md"):
	with open(f"{ROOT}/README.md", "r", encoding="utf-8") as file:
		DESCRIPTION_MARKDOWN = file.read()
else:
	print("README.md not found, description_markdown will be empty")

# Dependencies (list of modrinth slugs)
DEPENDENCIES: list[dict] = []

# Version type (release, beta, alpha)
VERSION_TYPE: str = "release"

# Configuration
modrinth_config: dict = {
	"slug": NAMESPACE,
	"project_name": PROJECT_NAME,
	"version": VERSION,
	"summary": SUMMARY,
	"description_markdown": DESCRIPTION_MARKDOWN,
	"dependencies": DEPENDENCIES,
	"version_type": VERSION_TYPE,
	"build_folder": BUILD_FOLDER,
}

