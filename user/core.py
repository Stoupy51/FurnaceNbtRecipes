
# ruff: noqa: E501
# Imports
from beet import Context
from stewbeet import write_versioned_function


# Setup core functions
def setup_core_functions(ctx: Context) -> None:
	ns: str = ctx.project_id
	version: str = ctx.project_version

	write_versioned_function("load_delayed", f"""
execute in minecraft:overworld run forceload add -30000000 1600
execute in minecraft:overworld run setblock -30000000 14 1610 yellow_shulker_box
execute unless loaded -30000000 14 1610 run schedule function {ns}:v{version}/load_delayed 2s replace
""")

	write_versioned_function("loop", f"""
# Tick function
schedule function {ns}:v{version}/loop 1t replace
execute as @e[type=marker,tag={ns}.furnace] at @s run function {ns}:v{version}/technical/tick
""")

