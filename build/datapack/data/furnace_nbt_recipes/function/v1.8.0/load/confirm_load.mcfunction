
#> furnace_nbt_recipes:v1.8.0/load/confirm_load
#
# @within	furnace_nbt_recipes:v1.8.0/load/secondary
#

tellraw @a[tag=convention.debug] {"text":"[Loaded FurnaceNbtRecipes v1.8.0]","color":"green"}

scoreboard players set #furnace_nbt_recipes.loaded load.status 1

# Objectives initialization
scoreboard objectives add furnace_nbt_recipes.data dummy

# Place a yellow shulker box for inventory manipulation
execute in minecraft:overworld run forceload add -30000000 1600

schedule function furnace_nbt_recipes:v1.8.0/load_delayed 2s replace
schedule function furnace_nbt_recipes:v1.8.0/loop 2s replace
