
#> furnace_nbt_recipes:v1.12.0/technical/destroy
#
# @executed	as @e[tag=furnace_nbt_recipes.furnace] & at @s
#
# @within	furnace_nbt_recipes:v1.12.0/technical/tick
#

execute if score @s furnace_nbt_recipes.stashed matches 1 run function furnace_nbt_recipes:v1.12.0/technical/drop_stash with entity @s data

# A marker is ours to remove, any other entity only stops being tracked
execute if entity @s[type=marker] run return run kill @s
tag @s remove furnace_nbt_recipes.furnace
scoreboard players reset @s furnace_nbt_recipes.speed
scoreboard players reset @s furnace_nbt_recipes.intended
scoreboard players reset @s furnace_nbt_recipes.progress
scoreboard players reset @s furnace_nbt_recipes.partial
scoreboard players reset @s furnace_nbt_recipes.stall_time
scoreboard players reset @s furnace_nbt_recipes.type

