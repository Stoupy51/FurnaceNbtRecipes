
#> furnace_nbt_recipes:v1.11.0/technical/tick
#
# @executed	as @e[type=marker,tag=furnace_nbt_recipes.furnace] & at @s
#
# @within	furnace_nbt_recipes:v1.11.0/loop [ as @e[type=marker,tag=furnace_nbt_recipes.furnace] & at @s ]
#

# Destroy marker entity if furnace is destroyed, and stop execution
execute unless block ~ ~ ~ #furnace_nbt_recipes:furnaces run return run function furnace_nbt_recipes:v1.11.0/technical/destroy

# Give back the output item parked for the lighting tick
execute if score @s furnace_nbt_recipes.stashed matches 1 unless data block ~ ~ ~ Items[{Slot:2b}] run function furnace_nbt_recipes:v1.11.0/technical/unstash

# Nothing to cook
execute unless data block ~ ~ ~ Items[{Slot:0b}] run return 0

# Run main while the fire burns, and while there is fuel left to light it
execute unless data block ~ ~ ~ {lit_time_remaining:0} run return run function furnace_nbt_recipes:v1.11.0/technical/main
execute if data block ~ ~ ~ Items[{Slot:1b}] run function furnace_nbt_recipes:v1.11.0/technical/main

