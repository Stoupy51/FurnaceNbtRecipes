
#> furnace_nbt_recipes:v1.9.1/loop
#
# @within	furnace_nbt_recipes:v1.9.1/load/confirm_load 2s replace
#			furnace_nbt_recipes:v1.9.1/loop 1t replace
#

# Tick function
schedule function furnace_nbt_recipes:v1.9.1/loop 1t replace
execute as @e[type=marker,tag=furnace_nbt_recipes.furnace] at @s run function furnace_nbt_recipes:v1.9.1/technical/tick

