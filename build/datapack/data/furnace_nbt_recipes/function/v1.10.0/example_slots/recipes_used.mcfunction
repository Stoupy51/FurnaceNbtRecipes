
#> furnace_nbt_recipes:v1.10.0/example_slots/recipes_used
#
# @within	???
#

##Called by function tag #furnace_nbt_recipes:v1.10.0/recipes_used
##Default recipe used is recipes/xp/1.0
##score #type furnace_nbt_recipes.data has 3 values:
##value 0: smelting
##value 1: blasting
##value 2: smoking

# Simplunium Ore (more xp with blast furnace)
execute if score #found furnace_nbt_recipes.data matches 0 store result score #found furnace_nbt_recipes.data if score #type furnace_nbt_recipes.data matches 0 if data storage furnace_nbt_recipes:main input.components."minecraft:custom_data".smithed.dict.ore.simplunium run function furnace_nbt_recipes:v1.10.0/example_slots/xp/2.0
execute if score #found furnace_nbt_recipes.data matches 0 store result score #found furnace_nbt_recipes.data if score #type furnace_nbt_recipes.data matches 1 if data storage furnace_nbt_recipes:main input.components."minecraft:custom_data".smithed.dict.ore.simplunium run function furnace_nbt_recipes:v1.10.0/example_slots/xp/2.5

# Simplunium Armor & Tools (2.0 xp)
execute if score #found furnace_nbt_recipes.data matches 0 store result score #found furnace_nbt_recipes.data if data storage furnace_nbt_recipes:main input.components."minecraft:custom_data".smithed.dict.armor.simplunium run function furnace_nbt_recipes:v1.10.0/example_slots/xp/2.0
execute if score #found furnace_nbt_recipes.data matches 0 store result score #found furnace_nbt_recipes.data if data storage furnace_nbt_recipes:main input.components."minecraft:custom_data".smithed.dict.tools.simplunium run function furnace_nbt_recipes:v1.10.0/example_slots/xp/2.0

