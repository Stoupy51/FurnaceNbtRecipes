
#> furnace_nbt_recipes:v1.10.2/technical/clock
#
# @executed	as @e[type=marker,tag=furnace_nbt_recipes.furnace] & at @s
#
# @within	furnace_nbt_recipes:v1.10.2/technical/main
#

## Own the cooking clock, vanilla would otherwise complete the recipe on its own
# Adopt the cooking time the game computed for this recipe, it accounts for the fuel speed multiplier
scoreboard players add @s furnace_nbt_recipes.intended 0
scoreboard players add @s furnace_nbt_recipes.progress 0
execute unless score #total_time furnace_nbt_recipes.data = #held furnace_nbt_recipes.data run function furnace_nbt_recipes:v1.10.2/technical/clock_reset

# Without a known duration, leave the furnace alone until it lights again and the game computes one
execute unless score @s furnace_nbt_recipes.intended matches 1.. run return 0

# Advance like vanilla does: forward while lit, backward once the fire is out
execute unless data block ~ ~ ~ {lit_time_remaining:0} run scoreboard players add @s furnace_nbt_recipes.progress 1
execute if data block ~ ~ ~ {lit_time_remaining:0} run scoreboard players remove @s furnace_nbt_recipes.progress 2
execute if score @s furnace_nbt_recipes.progress matches ..0 run scoreboard players set @s furnace_nbt_recipes.progress 0

# Hold the furnace clock, scaling our progress onto it so the progress arrow keeps its real ratio
scoreboard players operation #write furnace_nbt_recipes.data = #held furnace_nbt_recipes.data
scoreboard players operation #write furnace_nbt_recipes.data /= @s furnace_nbt_recipes.intended
scoreboard players operation #write furnace_nbt_recipes.data *= @s furnace_nbt_recipes.progress
execute store result block ~ ~ ~ cooking_time_spent int 1 run scoreboard players get #write furnace_nbt_recipes.data
execute store result block ~ ~ ~ cooking_total_time int 1 run scoreboard players get #held furnace_nbt_recipes.data

# Cook once the recipe got its full duration
execute if score @s furnace_nbt_recipes.progress >= @s furnace_nbt_recipes.intended run function furnace_nbt_recipes:v1.10.2/technical/cook

