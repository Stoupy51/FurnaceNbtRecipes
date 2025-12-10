
# ruff: noqa: E501
# Imports
import os

import stouputils as stp
from stewbeet import Advancement, BlockTag, Context, Function, FunctionTag, ItemTag, set_json_encoder, write_load_file, write_versioned_function


# Main function is run just before making finalyzing the build process (zip, headers, lang, ...)
def beet_default(ctx: Context) -> None:
	ns: str = ctx.project_id
	version: str = ctx.project_version
	major, minor, patch = version.split(".")

	# Write additional confirm load things
	write_load_file(f"""
# Objectives initialization
scoreboard objectives add {ns}.data dummy
scoreboard objectives add {ns}.stall_time dummy

# Place a yellow shulker box for inventory manipulation
execute in minecraft:overworld run forceload add -30000000 1600

schedule function {ns}:v{version}/load_delayed 2s replace
schedule function {ns}:v{version}/loop 2s replace
""")

	# Write functions that checks for version
	write_versioned_function("advancements/placed_furnace", f"""
advancement revoke @s only {ns}:v{version}/placed_furnace
execute if score #{ns}.major load.status matches {major} if score #{ns}.minor load.status matches {minor} if score #{ns}.patch load.status matches {patch} run function {ns}:v{version}/advancements/check_for_furnaces/look_all
""")

	# Write some tags
	ctx.data[ns].block_tags["furnaces"] = set_json_encoder(BlockTag({"values": ["furnace","blast_furnace","smoker"]}))
	ctx.data[ns].item_tags["armor/leather"] = set_json_encoder(ItemTag({"values": ["leather_helmet","leather_chestplate","leather_leggings","leather_boots"]}))
	ctx.data[ns].item_tags["tools/diamond"] = set_json_encoder(ItemTag({"values": ["diamond_sword","diamond_pickaxe","diamond_axe","diamond_shovel","diamond_hoe"]}))

	# Copy every file in the manual_merge folder
	MANUAL_MERGE_FOLDER: str = f"{ctx.directory}/manual_merge"
	for root, _, files in os.walk(MANUAL_MERGE_FOLDER):
		for file in files:
			src: str = stp.relative_path(f"{root}/{file}")
			dst: str = os.path.splitext(src.replace("VERSION", f"v{version}"))[0]
			with open(src) as f:
				content: str = f.read()
				content = content.replace("NAMESPACE", ns)
				content = content.replace("VERSION", f"v{version}")
				if "advancement/" in src:
					ctx.data[ns].advancements[dst.split("advancement/")[-1]] = set_json_encoder(Advancement(content), max_level=-1)
				elif "tags/function/" in src:
					ctx.data[ns].function_tags[dst.split("tags/function/")[-1]] = set_json_encoder(FunctionTag(content))
				elif "function/" in src:
					ctx.data[ns].functions[dst.split("function/")[-1]] = Function(content)
	pass

