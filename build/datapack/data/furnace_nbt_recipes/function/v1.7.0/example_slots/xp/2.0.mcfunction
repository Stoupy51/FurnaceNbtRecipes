
#> furnace_nbt_recipes:v1.7.0/example_slots/xp/2.0
#
# @within	furnace_nbt_recipes:v1.7.0/example_slots/recipes_used
#

scoreboard players set #count furnace_nbt_recipes.data 0
execute store result score #count furnace_nbt_recipes.data run data get storage furnace_nbt_recipes:main furnace.RecipesUsed."furnace_nbt_recipes:xp/2.0"
scoreboard players add #count furnace_nbt_recipes.data 1
execute store result block ~ ~ ~ RecipesUsed."furnace_nbt_recipes:xp/2.0" int 1 run scoreboard players get #count furnace_nbt_recipes.data
scoreboard players reset #count furnace_nbt_recipes.data
