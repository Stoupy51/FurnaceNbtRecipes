
# Destroy marker entity if furnace is destroyed
scoreboard players set #destroy furnace_nbt_recipes.data 0
execute store result score #destroy furnace_nbt_recipes.data unless block ~ ~ ~ #furnace_nbt_recipes:furnaces run kill @s

# Else, if furnace is not destroyed, run main function if furnace is cooking
execute if score #destroy furnace_nbt_recipes.data matches 0 unless data block ~ ~ ~ {CookTime:0s} run function furnace_nbt_recipes:v1.7.0/technical/main

