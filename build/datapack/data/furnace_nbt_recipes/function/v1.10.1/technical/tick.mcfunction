
#> furnace_nbt_recipes:v1.10.1/technical/tick
#
# @executed	as @e[type=marker,tag=furnace_nbt_recipes.furnace] & at @s
#
# @within	furnace_nbt_recipes:v1.10.1/loop [ as @e[type=marker,tag=furnace_nbt_recipes.furnace] & at @s ]
#

# Destroy marker entity if furnace is destroyed, and stop execution
execute unless block ~ ~ ~ #furnace_nbt_recipes:furnaces run return run kill @s

# Else, run main function if furnace is cooking
execute unless data block ~ ~ ~ {cooking_time_spent:0s} run return run function furnace_nbt_recipes:v1.10.1/technical/main

# If furnace has items but cooking_time_spent is 0, still run main to check for stalling
execute if data block ~ ~ ~ Items[{Slot:0b}] run function furnace_nbt_recipes:v1.10.1/technical/main

