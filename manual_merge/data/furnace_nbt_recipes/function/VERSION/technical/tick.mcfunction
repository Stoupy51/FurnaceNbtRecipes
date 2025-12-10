
# Destroy marker entity if furnace is destroyed, and stop execution
execute unless block ~ ~ ~ #furnace_nbt_recipes:furnaces run return run kill @s

# Else, run main function if furnace is cooking
execute unless data block ~ ~ ~ {cooking_time_spent:0s} run return run function furnace_nbt_recipes:VERSION/technical/main

# If furnace has items but cooking_time_spent is 0, still run main to check for stalling
execute if data block ~ ~ ~ Items[{Slot:0b}] run function furnace_nbt_recipes:VERSION/technical/main

