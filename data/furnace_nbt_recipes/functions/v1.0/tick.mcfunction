
#Tick function
schedule function furnace_nbt_recipes:v1.0/tick 1t replace
execute as @e[type=marker,tag=furnace_nbt_recipes.furnace] at @s run function furnace_nbt_recipes:v1.0/technical/tick

#Storage clear
data remove storage furnace_nbt_recipes:main furnace
data remove storage furnace_nbt_recipes:main input
