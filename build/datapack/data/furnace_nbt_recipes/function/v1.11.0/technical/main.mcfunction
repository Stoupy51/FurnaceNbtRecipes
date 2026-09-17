
#> furnace_nbt_recipes:v1.11.0/technical/main
#
# @executed	as @e[type=marker,tag=furnace_nbt_recipes.furnace] & at @s
#
# @within	furnace_nbt_recipes:v1.11.0/technical/tick
#

# Copy furnace nbt
data modify storage furnace_nbt_recipes:main furnace set from block ~ ~ ~

# Get what type of furnace is being used
scoreboard players set #type furnace_nbt_recipes.data 0
execute store result score #type furnace_nbt_recipes.data if block ~ ~ ~ blast_furnace
execute if score #type furnace_nbt_recipes.data matches 0 if block ~ ~ ~ blast_furnace run scoreboard players set #type furnace_nbt_recipes.data 1
execute if score #type furnace_nbt_recipes.data matches 0 if block ~ ~ ~ smoker run scoreboard players set #type furnace_nbt_recipes.data 2

## Storage manipulation
# Copy some nbt into scores
scoreboard players set #total_time furnace_nbt_recipes.data 0
execute store result score #cook_time furnace_nbt_recipes.data run data get storage furnace_nbt_recipes:main furnace.cooking_time_spent
execute store result score #total_time furnace_nbt_recipes.data run data get storage furnace_nbt_recipes:main furnace.cooking_total_time
data modify storage furnace_nbt_recipes:main input set from storage furnace_nbt_recipes:main furnace.Items[{Slot:0b}]

# Check if there is a recipe found
scoreboard players set #found furnace_nbt_recipes.data 0
execute in minecraft:overworld run data modify block -30000000 14 1610 Items set from storage furnace_nbt_recipes:main furnace.Items
execute in minecraft:overworld positioned -30000000 14 1610 run function furnace_nbt_recipes:v1.11.0/technical/call_recipes

## Disable cooking if not permitted (If no recipe is found and user conditions, or if the output slot holds another item)
scoreboard players set #reset furnace_nbt_recipes.data 0
execute if score #found furnace_nbt_recipes.data matches 0 run function #furnace_nbt_recipes:v1/disable_cooking
execute if score #found furnace_nbt_recipes.data matches 1 if data storage furnace_nbt_recipes:main furnace.Items[{Slot:2b}] run function furnace_nbt_recipes:v1.11.0/technical/same_output
execute if score #found furnace_nbt_recipes.data matches 1 if data storage furnace_nbt_recipes:main furnace.Items[{Slot:2b}] unless score #same furnace_nbt_recipes.data matches 2 run scoreboard players set #reset furnace_nbt_recipes.data 1

# Otherwise, continue
execute if score #reset furnace_nbt_recipes.data matches 0 if score #found furnace_nbt_recipes.data matches 1 if score #total_time furnace_nbt_recipes.data matches 1.. run function furnace_nbt_recipes:v1.11.0/technical/clock

# The fire paces the cooking, so stalling only counts while it is out
execute unless data block ~ ~ ~ {lit_time_remaining:0} run scoreboard players reset @s furnace_nbt_recipes.stall_time

# Track stalling: if recipe found but cooking_time_spent is 0, increment stall_time
execute if score #reset furnace_nbt_recipes.data matches 0 if score #found furnace_nbt_recipes.data matches 1 if score #cook_time furnace_nbt_recipes.data matches 0 run scoreboard players add @s furnace_nbt_recipes.stall_time 1

# Vanilla refuses to light while the output slot holds an item its own recipe cannot stack with, give it a free slot
execute if score #reset furnace_nbt_recipes.data matches 0 if score #found furnace_nbt_recipes.data matches 1 if score @s furnace_nbt_recipes.stall_time matches 5 if data block ~ ~ ~ {lit_time_remaining:0} if data block ~ ~ ~ Items[{Slot:1b}] if data block ~ ~ ~ Items[{Slot:2b}] run function furnace_nbt_recipes:v1.11.0/technical/ignite

# Force smelting if stalled for too long (100 ticks)
execute if score #reset furnace_nbt_recipes.data matches 0 if score #found furnace_nbt_recipes.data matches 1 if score @s furnace_nbt_recipes.stall_time matches 100.. run function furnace_nbt_recipes:v1.11.0/technical/cook

# Disable cooking if needed (+ compability with ICY's NBT Smelting library)
execute if score #reset furnace_nbt_recipes.data matches 1 run data modify block ~ ~ ~ cooking_time_spent set value 0
execute if score #reset furnace_nbt_recipes.data matches 1 if score #nbt_smelting.major load.status matches 1.. align xyz run scoreboard players set @e[tag=nbt_smelting.furnace.active,dx=-1,dy=-1,dz=-1] nbt_smelting.data 0

