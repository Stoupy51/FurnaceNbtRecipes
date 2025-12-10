
#> furnace_nbt_recipes:v1.10.0/advancements/placed_furnace
#
# @executed	as the player & at current position
#
# @within	advancement furnace_nbt_recipes:v1.10.0/placed_furnace
#

advancement revoke @s only furnace_nbt_recipes:v1.10.0/placed_furnace
execute if score #furnace_nbt_recipes.major load.status matches 1 if score #furnace_nbt_recipes.minor load.status matches 10 if score #furnace_nbt_recipes.patch load.status matches 0 run function furnace_nbt_recipes:v1.10.0/advancements/check_for_furnaces/look_all

