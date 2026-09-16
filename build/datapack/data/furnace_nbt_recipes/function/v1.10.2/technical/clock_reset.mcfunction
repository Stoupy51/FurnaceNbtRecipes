
#> furnace_nbt_recipes:v1.10.2/technical/clock_reset
#
# @executed	as @e[type=marker,tag=furnace_nbt_recipes.furnace] & at @s
#
# @within	furnace_nbt_recipes:v1.10.2/technical/clock
#

# A cooking time as long as the held one is a leftover hold, not a duration a recipe asked for
scoreboard players set @s furnace_nbt_recipes.intended 0
execute if score #total_time furnace_nbt_recipes.data < #held furnace_nbt_recipes.data run scoreboard players operation @s furnace_nbt_recipes.intended = #total_time furnace_nbt_recipes.data
execute if score #total_time furnace_nbt_recipes.data < #held furnace_nbt_recipes.data run scoreboard players operation @s furnace_nbt_recipes.progress = #cook_time furnace_nbt_recipes.data

