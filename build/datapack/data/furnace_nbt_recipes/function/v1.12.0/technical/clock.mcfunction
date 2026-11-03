
#> furnace_nbt_recipes:v1.12.0/technical/clock
#
# @executed	as @e[tag=furnace_nbt_recipes.furnace] & at @s
#
# @within	furnace_nbt_recipes:v1.12.0/technical/main
#

## Own the cooking clock, vanilla would otherwise complete the recipe on its own
# Adopt the cooking time the game computed for this recipe, it accounts for the fuel speed multiplier
scoreboard players add @s furnace_nbt_recipes.intended 0
scoreboard players add @s furnace_nbt_recipes.progress 0
execute unless score @s furnace_nbt_recipes.speed matches 1.. run scoreboard players set @s furnace_nbt_recipes.speed 1000
execute unless score #total_time furnace_nbt_recipes.data = #held furnace_nbt_recipes.data run function furnace_nbt_recipes:v1.12.0/technical/clock_reset

# Without a known duration, leave the furnace alone until it lights again and the game computes one
execute unless score @s furnace_nbt_recipes.intended matches 1.. run return 0

# Advance like vanilla does: forward while lit, backward once the fire is out
execute unless score #lit furnace_nbt_recipes.data matches 0 run scoreboard players operation @s furnace_nbt_recipes.partial += @s furnace_nbt_recipes.speed
scoreboard players operation #gain furnace_nbt_recipes.data = @s furnace_nbt_recipes.partial
scoreboard players operation #gain furnace_nbt_recipes.data /= #1000 furnace_nbt_recipes.data
scoreboard players operation @s furnace_nbt_recipes.progress += #gain furnace_nbt_recipes.data
scoreboard players operation #gain furnace_nbt_recipes.data *= #1000 furnace_nbt_recipes.data
scoreboard players operation @s furnace_nbt_recipes.partial -= #gain furnace_nbt_recipes.data
execute if score #lit furnace_nbt_recipes.data matches 0 run scoreboard players remove @s furnace_nbt_recipes.progress 2
execute if score @s furnace_nbt_recipes.progress matches ..0 run scoreboard players set @s furnace_nbt_recipes.progress 0
execute if score @s furnace_nbt_recipes.progress matches ..0 run scoreboard players set @s furnace_nbt_recipes.partial 0

# Hold the furnace clock, scaling our progress onto it so the progress arrow keeps its real ratio
scoreboard players operation #write furnace_nbt_recipes.data = #held furnace_nbt_recipes.data
scoreboard players operation #write furnace_nbt_recipes.data /= @s furnace_nbt_recipes.intended
scoreboard players operation #write furnace_nbt_recipes.data *= @s furnace_nbt_recipes.progress
execute unless score #total_time furnace_nbt_recipes.data = #held furnace_nbt_recipes.data store result block ~ ~ ~ cooking_total_time int 1 run scoreboard players get #held furnace_nbt_recipes.data

# Vanilla moves the clock by one every tick, so ours is only written once the arrow would show another of its 24 pixels, and always on the last one, where vanilla would otherwise complete the recipe
scoreboard players operation #pixel furnace_nbt_recipes.data = #write furnace_nbt_recipes.data
scoreboard players operation #pixel furnace_nbt_recipes.data /= #pixel_time furnace_nbt_recipes.data
scoreboard players operation #shown_pixel furnace_nbt_recipes.data = #cook_time furnace_nbt_recipes.data
scoreboard players operation #shown_pixel furnace_nbt_recipes.data /= #pixel_time furnace_nbt_recipes.data
execute if score #shown_pixel furnace_nbt_recipes.data matches 23.. run scoreboard players set #shown_pixel furnace_nbt_recipes.data -1
execute unless score #shown_pixel furnace_nbt_recipes.data = #pixel furnace_nbt_recipes.data store result block ~ ~ ~ cooking_time_spent int 1 run scoreboard players get #write furnace_nbt_recipes.data

# Cook once the recipe got its full duration
execute if score @s furnace_nbt_recipes.progress >= @s furnace_nbt_recipes.intended run function furnace_nbt_recipes:v1.12.0/technical/cook

