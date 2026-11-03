
#> furnace_nbt_recipes:v1.12.0/technical/cook
#
# @executed	as @e[tag=furnace_nbt_recipes.furnace] & at @s
#
# @within	furnace_nbt_recipes:v1.12.0/technical/clock
#			furnace_nbt_recipes:v1.12.0/technical/main
#

# Take the library output and consume one input item
execute in minecraft:overworld run function furnace_nbt_recipes:v1.12.0/technical/shulker_manipulation

# If shulker manipulation was not done, exit function
execute if score #reset furnace_nbt_recipes.data matches 0 run return 0

# Apply new storage values (because shulker manipulation was done)
data modify block ~ ~ ~ Items set from storage furnace_nbt_recipes:main furnace.Items

# The output was taken from the shulker box, and a loot table may roll another one for the next item
data remove storage furnace_nbt_recipes:main searched

# Apply XP support
scoreboard players set #found furnace_nbt_recipes.data 0
function #furnace_nbt_recipes:v1/recipes_used
# A handler called through 'store result ... run function' sets no #found when its function returns nothing, so its write to RecipesUsed counts too
execute if score #found furnace_nbt_recipes.data matches 0 store success score #found furnace_nbt_recipes.data run data modify storage furnace_nbt_recipes:main furnace.RecipesUsed set from block ~ ~ ~ RecipesUsed
execute if score #found furnace_nbt_recipes.data matches 0 run function furnace_nbt_recipes:v1.12.0/technical/default_xp

# Restart the cooking clock, handing the furnace back its real cooking time
execute if score @s furnace_nbt_recipes.intended matches 1.. store result block ~ ~ ~ cooking_total_time int 1 run scoreboard players get @s furnace_nbt_recipes.intended
data modify block ~ ~ ~ cooking_time_spent set value 0
scoreboard players set @s furnace_nbt_recipes.progress 0
scoreboard players set @s furnace_nbt_recipes.partial 0
scoreboard players reset @s furnace_nbt_recipes.stall_time

