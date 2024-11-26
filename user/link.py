
# Imports
from python_datapack.constants import *
from python_datapack.utils.print import *
from python_datapack.utils.io import *
from config import *

# Main function is run just before making finalyzing the build process (zip, headers, lang, ...)
def main(config: dict) -> None:
	namespace: str = config["namespace"]
	version: str = config["version"]
	major, minor, patch = version.split(".")

	# Write additional confirm load things
	write_to_load_file(config, f"""
# Objectives initialization
scoreboard objectives add furnace_nbt_recipes.data dummy

# Place a yellow shulker box for inventory manipulation
execute in minecraft:overworld run forceload add -30000000 1600

schedule function furnace_nbt_recipes:v{version}/load_delayed 2s replace
schedule function furnace_nbt_recipes:v{version}/loop 2s replace
""")
	
	# Copy every file in the manual_merge folder
	MANUAL_MERGE_FOLDER: str = f"{ROOT}/manual_merge"
	for root, _, files in os.walk(MANUAL_MERGE_FOLDER):
		for file in files:
			src: str = f"{root}/{file}"
			dst: str = src.replace(MANUAL_MERGE_FOLDER, f"{config['build_datapack']}").replace("VERSION", f"v{version}")
			with super_open(src, "r") as f:
				content: str = f.read()
				content = content.replace("NAMESPACE", namespace)
				content = content.replace("VERSION", f"v{version}")
				write_to_file(dst, content)
	pass

