
#> furnace_nbt_recipes:v1.9.1/technical/default_xp
#
# @within	furnace_nbt_recipes:v1.9.1/technical/cook
#

scoreboard players set #count furnace_nbt_recipes.data 0
execute store result score #count furnace_nbt_recipes.data run data get storage furnace_nbt_recipes:main furnace.RecipesUsed."furnace_nbt_recipes:xp/1.0"
scoreboard players add #count furnace_nbt_recipes.data 1
execute store result block ~ ~ ~ RecipesUsed."furnace_nbt_recipes:xp/1.0" int 1 run scoreboard players get #count furnace_nbt_recipes.data
scoreboard players reset #count furnace_nbt_recipes.data

