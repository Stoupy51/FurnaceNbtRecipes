
#Objectives initialization
scoreboard objectives add furnace_nbt_recipes.data dummy

#define storage furnace_nbt_recipes:main

#Place a yellow shulker box for inventory manipulation
execute in minecraft:overworld run forceload add -30000000 1600

schedule function furnace_nbt_recipes:v1.1/load_delayed 2s replace
schedule function furnace_nbt_recipes:v1.1/tick 2s replace
