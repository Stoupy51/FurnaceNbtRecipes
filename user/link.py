
# ruff: noqa: E501
# Imports
from stewbeet import BlockTag, Context, ItemTag, set_json_encoder, write_load_file, write_versioned_function

from user.check_for_furnaces import setup_check_for_furnaces_functions
from user.core import setup_core_functions
from user.example_slots import setup_example_slots_functions
from user.resources import setup_resources
from user.technical import setup_technical_functions


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
scoreboard objectives add {ns}.progress dummy
scoreboard objectives add {ns}.intended dummy
scoreboard objectives add {ns}.stashed dummy
scoreboard objectives add {ns}.speed dummy
scoreboard objectives add {ns}.partial dummy

# Cooking time held on furnaces running a custom recipe: high enough that vanilla never reaches it, low enough to stay in the 16 bits the furnace screen syncs
scoreboard players set #held {ns}.data 30000

# A speed is given per thousand, so a furnace can cook at a fraction of a tick per tick
scoreboard players set #1000 {ns}.data 1000

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

	# Setup json resources (placed furnace advancement, v1 api function tags)
	setup_resources(ctx)

	# Setup all functions (loading/loop, furnace detection, example slots, technical cooking)
	setup_core_functions(ctx)
	setup_check_for_furnaces_functions(ctx)
	setup_example_slots_functions(ctx)
	setup_technical_functions(ctx)

