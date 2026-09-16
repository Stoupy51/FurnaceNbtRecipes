
#> furnace_nbt_recipes:v1.10.2/technical/ignite
#
# @executed	as @e[type=marker,tag=furnace_nbt_recipes.furnace] & at @s
#
# @within	furnace_nbt_recipes:v1.10.2/technical/main
#

# Park the output item so that the furnace lights itself: it burns its own fuel and sets its own cooking speed
data modify entity @s data.stash set from storage furnace_nbt_recipes:main furnace.Items[{Slot:2b}]
data remove block ~ ~ ~ Items[{Slot:2b}]
scoreboard players set @s furnace_nbt_recipes.stashed 1

# Start from zero, the freed slot would otherwise let the vanilla recipe complete during that tick
data modify block ~ ~ ~ cooking_time_spent set value 0

