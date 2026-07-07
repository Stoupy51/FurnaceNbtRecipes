
# ruff: noqa: E501
# Imports
from beet import Context
from stewbeet import write_versioned_function


# Setup example slots functions
def setup_example_slots_functions(ctx: Context) -> None:
	ns: str = ctx.project_id
	version: str = ctx.project_version

	write_versioned_function("example_slots/blasting_recipes", f"""
##Called by function tag #{ns}:v{version}/smelting_recipes
##You are allowed to call a loot table with more than 1 output count.
##(x1 cobblestone -> x2 stone for instance)
##Here are some examples with SimplEnergy recipes

# # Simplunium Ore & Deepslate Simplunium Ore
# execute if score #found {ns}.data matches 0 store result score #found {ns}.data if data storage {ns}:main input.components."minecraft:custom_data".smithed.dict.ore.simplunium run loot replace block ~ ~ ~ container.3 loot simplenergy:i/simplunium_ingot

# # Raw Simplunium
# execute if score #found {ns}.data matches 0 store result score #found {ns}.data if data storage {ns}:main input.components."minecraft:custom_data".smithed.dict.raw.simplunium run loot replace block ~ ~ ~ container.3 loot simplenergy:i/simplunium_ingot

# # Simplunium Armor & Tools
# execute if score #found {ns}.data matches 0 store result score #found {ns}.data if data storage {ns}:main input.components."minecraft:custom_data".smithed.dict.armor.simplunium run loot replace block ~ ~ ~ container.3 loot simplenergy:i/simplunium_nugget
# execute if score #found {ns}.data matches 0 store result score #found {ns}.data if data storage {ns}:main input.components."minecraft:custom_data".smithed.dict.tools.simplunium run loot replace block ~ ~ ~ container.3 loot simplenergy:i/simplunium_nugget
""")

	write_versioned_function("example_slots/disable_cooking", f"""
##Called by function tag #{ns}:v{version}/disable_cooking
##In this function, you should only disable recipes that you added yourself.
##For instance, barrel and command_block recipes are added by default
##in the {ns}/recipes/ folder.

execute if score #reset {ns}.data matches 0 store success score #reset {ns}.data if data storage {ns}:main input{{id:"minecraft:barrel"}}
execute if score #reset {ns}.data matches 0 store success score #reset {ns}.data if data storage {ns}:main input{{id:"minecraft:command_block"}}
execute if score #reset {ns}.data matches 0 store success score #reset {ns}.data if data storage {ns}:main input{{id:"minecraft:structure_block"}}
execute if score #reset {ns}.data matches 0 store success score #reset {ns}.data if data storage {ns}:main input{{id:"minecraft:leather_helmet"}}
execute if score #reset {ns}.data matches 0 store success score #reset {ns}.data if data storage {ns}:main input{{id:"minecraft:leather_chestplate"}}
execute if score #reset {ns}.data matches 0 store success score #reset {ns}.data if data storage {ns}:main input{{id:"minecraft:leather_leggings"}}
execute if score #reset {ns}.data matches 0 store success score #reset {ns}.data if data storage {ns}:main input{{id:"minecraft:leather_boots"}}
execute if score #reset {ns}.data matches 0 store success score #reset {ns}.data if data storage {ns}:main input{{id:"minecraft:diamond_sword"}}
execute if score #reset {ns}.data matches 0 store success score #reset {ns}.data if data storage {ns}:main input{{id:"minecraft:diamond_pickaxe"}}
execute if score #reset {ns}.data matches 0 store success score #reset {ns}.data if data storage {ns}:main input{{id:"minecraft:diamond_axe"}}
execute if score #reset {ns}.data matches 0 store success score #reset {ns}.data if data storage {ns}:main input{{id:"minecraft:diamond_hoe"}}
execute if score #reset {ns}.data matches 0 store success score #reset {ns}.data if data storage {ns}:main input{{id:"minecraft:diamond_shovel"}}
""")

	write_versioned_function("example_slots/recipes_used", f"""
##Called by function tag #{ns}:v{version}/recipes_used
##Default recipe used is recipes/xp/1.0
##score #type {ns}.data has 3 values:
##value 0: smelting
##value 1: blasting
##value 2: smoking

# Simplunium Ore (more xp with blast furnace)
execute if score #found {ns}.data matches 0 store result score #found {ns}.data if score #type {ns}.data matches 0 if data storage {ns}:main input.components."minecraft:custom_data".smithed.dict.ore.simplunium run function {ns}:v{version}/example_slots/xp/2.0
execute if score #found {ns}.data matches 0 store result score #found {ns}.data if score #type {ns}.data matches 1 if data storage {ns}:main input.components."minecraft:custom_data".smithed.dict.ore.simplunium run function {ns}:v{version}/example_slots/xp/2.5

# Simplunium Armor & Tools (2.0 xp)
execute if score #found {ns}.data matches 0 store result score #found {ns}.data if data storage {ns}:main input.components."minecraft:custom_data".smithed.dict.armor.simplunium run function {ns}:v{version}/example_slots/xp/2.0
execute if score #found {ns}.data matches 0 store result score #found {ns}.data if data storage {ns}:main input.components."minecraft:custom_data".smithed.dict.tools.simplunium run function {ns}:v{version}/example_slots/xp/2.0

""")

	write_versioned_function("example_slots/smelting_recipes", f"""
##Called by function tag #{ns}:v{version}/smelting_recipes
##You are allowed to call a loot table with more than 1 output count.
##(x1 cobblestone -> x2 stone for instance)
##Here are some examples with SimplEnergy recipes

# # Simplunium Ore & Deepslate Simplunium Ore
# execute if score #found {ns}.data matches 0 store result score #found {ns}.data if data storage {ns}:main input.components."minecraft:custom_data".smithed.dict.ore.simplunium run loot replace block ~ ~ ~ container.3 loot simplenergy:i/simplunium_ingot

# # Raw Simplunium
# execute if score #found {ns}.data matches 0 store result score #found {ns}.data if data storage {ns}:main input.components."minecraft:custom_data".smithed.dict.raw.simplunium run loot replace block ~ ~ ~ container.3 loot simplenergy:i/simplunium_ingot

# # Simplunium Armor & Tools
# execute if score #found {ns}.data matches 0 store result score #found {ns}.data if data storage {ns}:main input.components."minecraft:custom_data".smithed.dict.armor.simplunium run loot replace block ~ ~ ~ container.3 loot simplenergy:i/simplunium_nugget
# execute if score #found {ns}.data matches 0 store result score #found {ns}.data if data storage {ns}:main input.components."minecraft:custom_data".smithed.dict.tools.simplunium run loot replace block ~ ~ ~ container.3 loot simplenergy:i/simplunium_nugget
""")

	write_versioned_function("example_slots/smoking_recipes", """

""")

	write_versioned_function("example_slots/xp/1.0", f"""
scoreboard players set #count {ns}.data 0
execute store result score #count {ns}.data run data get storage {ns}:main furnace.RecipesUsed."{ns}:xp/1.0"
scoreboard players add #count {ns}.data 1
execute store result block ~ ~ ~ RecipesUsed."{ns}:xp/1.0" int 1 run scoreboard players get #count {ns}.data
scoreboard players reset #count {ns}.data
""")

	write_versioned_function("example_slots/xp/2.0", f"""
scoreboard players set #count {ns}.data 0
execute store result score #count {ns}.data run data get storage {ns}:main furnace.RecipesUsed."{ns}:xp/2.0"
scoreboard players add #count {ns}.data 1
execute store result block ~ ~ ~ RecipesUsed."{ns}:xp/2.0" int 1 run scoreboard players get #count {ns}.data
scoreboard players reset #count {ns}.data
""")

	write_versioned_function("example_slots/xp/2.5", f"""
scoreboard players set #count {ns}.data 0
execute store result score #count {ns}.data run data get storage {ns}:main furnace.RecipesUsed."{ns}:xp/2.5"
scoreboard players add #count {ns}.data 1
execute store result block ~ ~ ~ RecipesUsed."{ns}:xp/2.5" int 1 run scoreboard players get #count {ns}.data
scoreboard players reset #count {ns}.data
""")

	write_versioned_function("example_slots/xp/50.0", f"""
scoreboard players set #count {ns}.data 0
execute store result score #count {ns}.data run data get storage {ns}:main furnace.RecipesUsed."{ns}:xp/50.0"
scoreboard players add #count {ns}.data 1
execute store result block ~ ~ ~ RecipesUsed."{ns}:xp/50.0" int 1 run scoreboard players get #count {ns}.data
scoreboard players reset #count {ns}.data
""")

	write_versioned_function("example_slots/xp/50000.0", f"""
scoreboard players set #count {ns}.data 0
execute store result score #count {ns}.data run data get storage {ns}:main furnace.RecipesUsed."{ns}:xp/50000.0"
scoreboard players add #count {ns}.data 1
execute store result block ~ ~ ~ RecipesUsed."{ns}:xp/50000.0" int 1 run scoreboard players get #count {ns}.data
scoreboard players reset #count {ns}.data
""")

