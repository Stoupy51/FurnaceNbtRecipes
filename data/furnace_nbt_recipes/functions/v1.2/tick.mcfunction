
# Tick function
schedule function furnace_nbt_recipes:v1.2/tick 1t replace
execute as @e[type=marker,tag=furnace_nbt_recipes.furnace] at @s run function furnace_nbt_recipes:v1.2/technical/tick

