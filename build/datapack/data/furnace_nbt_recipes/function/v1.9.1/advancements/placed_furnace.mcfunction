
#> furnace_nbt_recipes:v1.9.1/advancements/placed_furnace
#
# @within	advancement furnace_nbt_recipes:v1.9.1/placed_furnace
#

advancement revoke @s only furnace_nbt_recipes:v1.9.1/placed_furnace
execute if score #furnace_nbt_recipes.major load.status matches 1 if score #furnace_nbt_recipes.minor load.status matches 9 if score #furnace_nbt_recipes.patch load.status matches 1 run function furnace_nbt_recipes:v1.9.1/advancements/check_for_furnaces/look_all

