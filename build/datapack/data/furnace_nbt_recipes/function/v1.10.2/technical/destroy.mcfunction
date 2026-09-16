
#> furnace_nbt_recipes:v1.10.2/technical/destroy
#
# @executed	as @e[type=marker,tag=furnace_nbt_recipes.furnace] & at @s
#
# @within	furnace_nbt_recipes:v1.10.2/technical/tick
#

execute if score @s furnace_nbt_recipes.stashed matches 1 run function furnace_nbt_recipes:v1.10.2/technical/drop_stash with entity @s data
kill @s

