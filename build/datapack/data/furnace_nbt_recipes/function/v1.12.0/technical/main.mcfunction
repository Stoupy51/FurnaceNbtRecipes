
#> furnace_nbt_recipes:v1.12.0/technical/main
#
# @executed	as @e[tag=furnace_nbt_recipes.furnace] & at @s
#
# @within	furnace_nbt_recipes:v1.12.0/technical/tick
#

# Work while the fire burns, and while there is fuel left to light it
execute store result score #lit furnace_nbt_recipes.data if block ~ ~ ~ #furnace_nbt_recipes:furnaces[lit=true]
execute if score #lit furnace_nbt_recipes.data matches 0 unless items block ~ ~ ~ container.1 * run return 0

# Copy furnace nbt once, the checks below read this copy
data modify storage furnace_nbt_recipes:main furnace set from block ~ ~ ~

# A tracked furnace keeps its block, so its type is read once, whatever entity tracks it
execute unless score @s furnace_nbt_recipes.type matches 0.. run function furnace_nbt_recipes:v1.12.0/technical/furnace_type
scoreboard players operation #type furnace_nbt_recipes.data = @s furnace_nbt_recipes.type

## Storage manipulation
# Copy some nbt into scores
scoreboard players set #total_time furnace_nbt_recipes.data 0
execute store result score #cook_time furnace_nbt_recipes.data run data get storage furnace_nbt_recipes:main furnace.cooking_time_spent
execute store result score #total_time furnace_nbt_recipes.data run data get storage furnace_nbt_recipes:main furnace.cooking_total_time
data modify storage furnace_nbt_recipes:main input set from storage furnace_nbt_recipes:main furnace.Items[{Slot:0b}]

# Search the recipe only when the ingredient or the furnace type differs from the last search, whichever furnace ran it
data modify storage furnace_nbt_recipes:main ingredient set from storage furnace_nbt_recipes:main input
data remove storage furnace_nbt_recipes:main ingredient.count
execute store result storage furnace_nbt_recipes:main ingredient.furnace_type byte 1 run scoreboard players get #type furnace_nbt_recipes.data
execute store success score #new_ingredient furnace_nbt_recipes.data run data modify storage furnace_nbt_recipes:main searched set from storage furnace_nbt_recipes:main ingredient
execute if score #new_ingredient furnace_nbt_recipes.data matches 1 in minecraft:overworld run function furnace_nbt_recipes:v1.12.0/technical/search_recipe
scoreboard players operation #found furnace_nbt_recipes.data = #searched_found furnace_nbt_recipes.data
scoreboard players operation #reset furnace_nbt_recipes.data = #searched_reset furnace_nbt_recipes.data

## Disable cooking if not permitted (If no recipe is found and user conditions, or if the output slot holds another item or is full)
execute if score #found furnace_nbt_recipes.data matches 1 if data storage furnace_nbt_recipes:main furnace.Items[{Slot:2b}] run function furnace_nbt_recipes:v1.12.0/technical/same_output

# Otherwise, continue
execute if score #reset furnace_nbt_recipes.data matches 0 if score #found furnace_nbt_recipes.data matches 1 if score #total_time furnace_nbt_recipes.data matches 1.. run function furnace_nbt_recipes:v1.12.0/technical/clock

# A vanilla recipe keeps the vanilla clock, so a furnace configured faster than 1000 gets its extra progress here
execute if score #reset furnace_nbt_recipes.data matches 0 if score #found furnace_nbt_recipes.data matches 0 if score @s furnace_nbt_recipes.speed matches 1001.. if score #cook_time furnace_nbt_recipes.data matches 1.. if score #total_time furnace_nbt_recipes.data matches 1..29999 unless score #lit furnace_nbt_recipes.data matches 0 run function furnace_nbt_recipes:v1.12.0/technical/vanilla_clock

# The fire paces the cooking, so stalling only counts while it is out
execute unless score #lit furnace_nbt_recipes.data matches 0 run scoreboard players reset @s furnace_nbt_recipes.stall_time

# Track stalling: if recipe found but cooking_time_spent is 0, increment stall_time
execute if score #reset furnace_nbt_recipes.data matches 0 if score #found furnace_nbt_recipes.data matches 1 if score #cook_time furnace_nbt_recipes.data matches 0 run scoreboard players add @s furnace_nbt_recipes.stall_time 1

# Vanilla refuses to light while the output slot holds an item its own recipe cannot stack with, give it a free slot
execute if score #reset furnace_nbt_recipes.data matches 0 if score #found furnace_nbt_recipes.data matches 1 if entity @s[type=marker] if score @s furnace_nbt_recipes.stall_time matches 5 if score #lit furnace_nbt_recipes.data matches 0 if items block ~ ~ ~ container.1 * if items block ~ ~ ~ container.2 * run function furnace_nbt_recipes:v1.12.0/technical/ignite

# Force smelting if stalled for too long (100 ticks)
execute if score #reset furnace_nbt_recipes.data matches 0 if score #found furnace_nbt_recipes.data matches 1 if score @s furnace_nbt_recipes.stall_time matches 100.. run function furnace_nbt_recipes:v1.12.0/technical/cook

# Disable cooking if needed (+ compability with ICY's NBT Smelting library)
execute if score #reset furnace_nbt_recipes.data matches 1 unless score #cook_time furnace_nbt_recipes.data matches 0 run data modify block ~ ~ ~ cooking_time_spent set value 0
execute if score #reset furnace_nbt_recipes.data matches 1 if score #nbt_smelting.major load.status matches 1.. align xyz run scoreboard players set @e[tag=nbt_smelting.furnace.active,dx=-1,dy=-1,dz=-1] nbt_smelting.data 0

