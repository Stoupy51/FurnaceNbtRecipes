
#> furnace_nbt_recipes:v1.11.0/technical/unstash
#
# @executed	as @e[type=marker,tag=furnace_nbt_recipes.furnace] & at @s
#
# @within	furnace_nbt_recipes:v1.11.0/technical/tick
#

# The stash keeps its own Slot, appending it in a single command puts it straight back in the output slot
data modify block ~ ~ ~ Items append from entity @s data.stash
data remove entity @s data.stash
scoreboard players set @s furnace_nbt_recipes.stashed 0

