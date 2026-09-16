
#> furnace_nbt_recipes:v1.10.2/technical/cook
#
# @executed	as @e[type=marker,tag=furnace_nbt_recipes.furnace] & at @s
#
# @within	furnace_nbt_recipes:v1.10.2/technical/clock
#			furnace_nbt_recipes:v1.10.2/technical/main
#

# Take the library output and consume one input item
execute in minecraft:overworld run function furnace_nbt_recipes:v1.10.2/technical/shulker_manipulation

# If shulker manipulation was not done, exit function
execute if score #reset furnace_nbt_recipes.data matches 0 run return 0

# Apply new storage values (because shulker manipulation was done)
data modify block ~ ~ ~ Items set from storage furnace_nbt_recipes:main furnace.Items

# Apply XP support
scoreboard players set #found furnace_nbt_recipes.data 0
function #furnace_nbt_recipes:v1/recipes_used
execute if score #found furnace_nbt_recipes matches 0 run function furnace_nbt_recipes:v1.10.2/technical/default_xp

# Restart the cooking clock, handing the furnace back its real cooking time
execute if score @s furnace_nbt_recipes.intended matches 1.. store result block ~ ~ ~ cooking_total_time int 1 run scoreboard players get @s furnace_nbt_recipes.intended
data modify block ~ ~ ~ cooking_time_spent set value 0
scoreboard players set @s furnace_nbt_recipes.progress 0
scoreboard players reset @s furnace_nbt_recipes.stall_time

