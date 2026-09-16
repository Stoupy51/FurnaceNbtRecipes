
#> furnace_nbt_recipes:v1.10.2/load/confirm_load
#
# @within	furnace_nbt_recipes:v1.10.2/load/secondary
#

# Confirm load
tellraw @a[tag=convention.debug] {"text":"[Loaded FurnaceNbtRecipes v1.10.2]","color":"green"}
scoreboard players set #furnace_nbt_recipes.loaded load.status 1
function furnace_nbt_recipes:v1.10.2/load/set_items_storage

# Objectives initialization
scoreboard objectives add furnace_nbt_recipes.data dummy
scoreboard objectives add furnace_nbt_recipes.stall_time dummy

# Place a yellow shulker box for inventory manipulation
execute in minecraft:overworld run forceload add -30000000 1600

schedule function furnace_nbt_recipes:v1.10.2/load_delayed 2s replace
schedule function furnace_nbt_recipes:v1.10.2/loop 2s replace

