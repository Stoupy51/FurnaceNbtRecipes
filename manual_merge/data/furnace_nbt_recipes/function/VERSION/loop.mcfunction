
# Tick function
schedule function furnace_nbt_recipes:VERSION/loop 1t replace
execute as @e[type=marker,tag=furnace_nbt_recipes.furnace] at @s run function furnace_nbt_recipes:VERSION/technical/tick

