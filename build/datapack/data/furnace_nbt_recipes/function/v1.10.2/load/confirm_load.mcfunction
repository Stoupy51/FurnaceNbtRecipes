
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
scoreboard objectives add furnace_nbt_recipes.progress dummy
scoreboard objectives add furnace_nbt_recipes.intended dummy
scoreboard objectives add furnace_nbt_recipes.stashed dummy

# Cooking time held on furnaces running a custom recipe: high enough that vanilla never reaches it, low enough to stay in the 16 bits the furnace screen syncs
scoreboard players set #held furnace_nbt_recipes.data 30000

# Place a yellow shulker box for inventory manipulation
execute in minecraft:overworld run forceload add -30000000 1600

schedule function furnace_nbt_recipes:v1.10.2/load_delayed 2s replace
schedule function furnace_nbt_recipes:v1.10.2/loop 2s replace

