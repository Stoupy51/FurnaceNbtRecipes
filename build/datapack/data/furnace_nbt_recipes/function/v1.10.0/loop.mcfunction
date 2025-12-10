
#> furnace_nbt_recipes:v1.10.0/loop
#
# @within	furnace_nbt_recipes:v1.10.0/load/confirm_load 2s replace [ scheduled ]
#			furnace_nbt_recipes:v1.10.0/loop 1t replace [ scheduled ]
#

# Tick function
schedule function furnace_nbt_recipes:v1.10.0/loop 1t replace
execute as @e[type=marker,tag=furnace_nbt_recipes.furnace] at @s run function furnace_nbt_recipes:v1.10.0/technical/tick

