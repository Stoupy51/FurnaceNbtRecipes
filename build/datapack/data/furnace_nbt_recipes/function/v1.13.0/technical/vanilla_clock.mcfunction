
#> furnace_nbt_recipes:v1.13.0/technical/vanilla_clock
#
# @executed	as @e[tag=furnace_nbt_recipes.furnace] & at @s
#
# @within	furnace_nbt_recipes:v1.13.0/technical/main
#

# Vanilla already adds one tick of progress, add what the configured speed gives on top of it
scoreboard players operation @s furnace_nbt_recipes.partial += @s furnace_nbt_recipes.speed
scoreboard players remove @s furnace_nbt_recipes.partial 1000
scoreboard players operation #gain furnace_nbt_recipes.data = @s furnace_nbt_recipes.partial
scoreboard players operation #gain furnace_nbt_recipes.data /= #1000 furnace_nbt_recipes.data
scoreboard players operation @s furnace_nbt_recipes.partial %= #1000 furnace_nbt_recipes.data
scoreboard players operation #cook_time furnace_nbt_recipes.data += #gain furnace_nbt_recipes.data

# Stay one tick short of completion, vanilla completes the recipe on its own next tick
scoreboard players remove #total_time furnace_nbt_recipes.data 1
execute if score #cook_time furnace_nbt_recipes.data > #total_time furnace_nbt_recipes.data run scoreboard players operation #cook_time furnace_nbt_recipes.data = #total_time furnace_nbt_recipes.data
execute store result block ~ ~ ~ cooking_time_spent int 1 run scoreboard players get #cook_time furnace_nbt_recipes.data

