
#> furnace_nbt_recipes:v1.10.2/technical/same_output
#
# @executed	as @e[type=marker,tag=furnace_nbt_recipes.furnace] & at @s
#
# @within	furnace_nbt_recipes:v1.10.2/technical/main
#

# Compare the library output with the item already sitting in the output slot, count and slot aside
data modify storage furnace_nbt_recipes:main check.lib set from block -30000000 14 1610 Items[{Slot:3b}]
data modify storage furnace_nbt_recipes:main check.fur set from storage furnace_nbt_recipes:main furnace.Items[{Slot:2b}]
data remove storage furnace_nbt_recipes:main check.lib.count
data remove storage furnace_nbt_recipes:main check.lib.Slot
data remove storage furnace_nbt_recipes:main check.fur.count
data remove storage furnace_nbt_recipes:main check.fur.Slot

# Matching both ways means the two items are the same, #same reaches 2
scoreboard players set #same furnace_nbt_recipes.data 0
function furnace_nbt_recipes:v1.10.2/technical/same_output_check with storage furnace_nbt_recipes:main check

