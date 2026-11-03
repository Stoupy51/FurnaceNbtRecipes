
#> furnace_nbt_recipes:v1.13.0/technical/tick
#
# @executed	as @e[tag=furnace_nbt_recipes.furnace] & at @s
#
# @within	furnace_nbt_recipes:v1.13.0/loop [ as @e[tag=furnace_nbt_recipes.furnace] & at @s ]
#

# Destroy marker entity if furnace is destroyed, and stop execution
execute unless block ~ ~ ~ #furnace_nbt_recipes:furnaces run return run function furnace_nbt_recipes:v1.13.0/technical/destroy

# Give back the output item parked for the lighting tick
execute if score @s furnace_nbt_recipes.stashed matches 1 unless data block ~ ~ ~ Items[{Slot:2b}] run function furnace_nbt_recipes:v1.13.0/technical/unstash

# Nothing to cook
execute unless items block ~ ~ ~ container.0 * run return 0
function furnace_nbt_recipes:v1.13.0/technical/main

