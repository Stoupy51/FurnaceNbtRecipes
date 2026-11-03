
#> furnace_nbt_recipes:v1.13.0/load/confirm_load
#
# @within	furnace_nbt_recipes:v1.13.0/load/secondary
#

# Confirm load
tellraw @a[tag=convention.debug] {"text":"[Loaded FurnaceNbtRecipes v1.13.0]","color":"green"}
scoreboard players set #furnace_nbt_recipes.loaded load.status 1

# Objectives initialization
scoreboard objectives add furnace_nbt_recipes.data dummy
scoreboard objectives add furnace_nbt_recipes.stall_time dummy
scoreboard objectives add furnace_nbt_recipes.progress dummy
scoreboard objectives add furnace_nbt_recipes.intended dummy
scoreboard objectives add furnace_nbt_recipes.stashed dummy
scoreboard objectives add furnace_nbt_recipes.speed dummy
scoreboard objectives add furnace_nbt_recipes.partial dummy
scoreboard objectives add furnace_nbt_recipes.type dummy

# Cooking time held on furnaces running a custom recipe: high enough that vanilla never reaches it, low enough to stay in the 16 bits the furnace screen syncs
scoreboard players set #held furnace_nbt_recipes.data 30000

# A speed is given per thousand, so a furnace can cook at a fraction of a tick per tick
scoreboard players set #1000 furnace_nbt_recipes.data 1000

# Held cooking time one pixel of the 24 pixel progress arrow stands for
scoreboard players set #pixel_time furnace_nbt_recipes.data 1250

# Recipes may differ after a reload, so the next furnace searches its recipe again
data remove storage furnace_nbt_recipes:main searched

# Place a yellow shulker box for inventory manipulation
execute in minecraft:overworld run forceload add -30000000 1600

schedule function furnace_nbt_recipes:v1.13.0/load_delayed 2s replace
schedule function furnace_nbt_recipes:v1.13.0/loop 2s replace

