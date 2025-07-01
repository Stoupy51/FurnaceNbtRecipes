
#> furnace_nbt_recipes:v1.9.1/technical/tick
#
# @within	furnace_nbt_recipes:v1.9.1/loop
#

# Destroy marker entity if furnace is destroyed
scoreboard players set #destroy furnace_nbt_recipes.data 0
execute store result score #destroy furnace_nbt_recipes.data unless block ~ ~ ~ #furnace_nbt_recipes:furnaces run kill @s

# Else, if furnace is not destroyed, run main function if furnace is cooking
execute if score #destroy furnace_nbt_recipes.data matches 0 unless data block ~ ~ ~ {cooking_time_spent:0s} run function furnace_nbt_recipes:v1.9.1/technical/main

