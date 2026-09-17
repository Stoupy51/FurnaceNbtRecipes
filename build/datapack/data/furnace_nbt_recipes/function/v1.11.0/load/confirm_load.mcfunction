
#> furnace_nbt_recipes:v1.11.0/load/confirm_load
#
# @within	furnace_nbt_recipes:v1.11.0/load/secondary
#

# Confirm load
tellraw @a[tag=convention.debug] {"text":"[Loaded FurnaceNbtRecipes v1.11.0]","color":"green"}
scoreboard players set #furnace_nbt_recipes.loaded load.status 1
function furnace_nbt_recipes:v1.11.0/load/set_items_storage

# Objectives initialization
scoreboard objectives add furnace_nbt_recipes.data dummy
scoreboard objectives add furnace_nbt_recipes.stall_time dummy
scoreboard objectives add furnace_nbt_recipes.progress dummy
scoreboard objectives add furnace_nbt_recipes.intended dummy
scoreboard objectives add furnace_nbt_recipes.stashed dummy
scoreboard objectives add furnace_nbt_recipes.speed dummy
scoreboard objectives add furnace_nbt_recipes.partial dummy

# Cooking time held on furnaces running a custom recipe: high enough that vanilla never reaches it, low enough to stay in the 16 bits the furnace screen syncs
scoreboard players set #held furnace_nbt_recipes.data 30000

# A speed is given per thousand, so a furnace can cook at a fraction of a tick per tick
scoreboard players set #1000 furnace_nbt_recipes.data 1000

# Place a yellow shulker box for inventory manipulation
execute in minecraft:overworld run forceload add -30000000 1600

schedule function furnace_nbt_recipes:v1.11.0/load_delayed 2s replace
schedule function furnace_nbt_recipes:v1.11.0/loop 2s replace

