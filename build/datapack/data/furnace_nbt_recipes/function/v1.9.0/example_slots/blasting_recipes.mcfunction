
#> furnace_nbt_recipes:v1.9.0/example_slots/blasting_recipes
#
# @within	???
#

##Called by function tag #furnace_nbt_recipes:v1.9.0/smelting_recipes
##You are allowed to call a loot table with more than 1 output count.
##(x1 cobblestone -> x2 stone for instance)
##Here are some examples with SimplEnergy recipes

# # Simplunium Ore & Deepslate Simplunium Ore
# execute if score #found furnace_nbt_recipes.data matches 0 store result score #found furnace_nbt_recipes.data if data storage furnace_nbt_recipes:main input.components."minecraft:custom_data".smithed.dict.ore.simplunium run loot replace block ~ ~ ~ container.3 loot simplenergy:i/simplunium_ingot

# # Raw Simplunium
# execute if score #found furnace_nbt_recipes.data matches 0 store result score #found furnace_nbt_recipes.data if data storage furnace_nbt_recipes:main input.components."minecraft:custom_data".smithed.dict.raw.simplunium run loot replace block ~ ~ ~ container.3 loot simplenergy:i/simplunium_ingot

# # Simplunium Armor & Tools
# execute if score #found furnace_nbt_recipes.data matches 0 store result score #found furnace_nbt_recipes.data if data storage furnace_nbt_recipes:main input.components."minecraft:custom_data".smithed.dict.armor.simplunium run loot replace block ~ ~ ~ container.3 loot simplenergy:i/simplunium_nugget
# execute if score #found furnace_nbt_recipes.data matches 0 store result score #found furnace_nbt_recipes.data if data storage furnace_nbt_recipes:main input.components."minecraft:custom_data".smithed.dict.tools.simplunium run loot replace block ~ ~ ~ container.3 loot simplenergy:i/simplunium_nugget

