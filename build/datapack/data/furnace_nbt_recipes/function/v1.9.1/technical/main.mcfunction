
#> furnace_nbt_recipes:v1.9.1/technical/main
#
# @within	furnace_nbt_recipes:v1.9.1/technical/tick
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
execute store result score #cook_time furnace_nbt_recipes.data run data get storage furnace_nbt_recipes:main furnace.cooking_time_spent
execute store result score #output_cmd furnace_nbt_recipes.data run data get storage furnace_nbt_recipes:main furnace.Items[{Slot:2b}].components."minecraft:custom_model_data"
data modify storage furnace_nbt_recipes:main input set from storage furnace_nbt_recipes:main furnace.Items[{Slot:0b}]

# Check if there is a recipe found
scoreboard players set #found furnace_nbt_recipes.data 0
execute in minecraft:overworld run data modify block -30000000 14 1610 Items set from storage furnace_nbt_recipes:main furnace.Items
execute in minecraft:overworld positioned -30000000 14 1610 run function furnace_nbt_recipes:v1.9.1/technical/call_recipes

# Get in a score the expected Custom Model Data
execute store result score #excepted_cmd furnace_nbt_recipes.data in minecraft:overworld run data get block -30000000 14 1610 Items[{Slot:3b}].components."minecraft:custom_model_data"

## Disable cooking if not permitted (If no recipe is found and user conditions, or if the output is not the expected one)
scoreboard players set #reset furnace_nbt_recipes.data 0
execute if score #found furnace_nbt_recipes.data matches 0 run function #furnace_nbt_recipes:v1/disable_cooking
execute if score #reset furnace_nbt_recipes.data matches 0 store success score #reset furnace_nbt_recipes.data unless score #output_cmd furnace_nbt_recipes.data matches 0 unless score #output_cmd furnace_nbt_recipes.data = #excepted_cmd furnace_nbt_recipes.data

# Otherwise, continue
execute if score #reset furnace_nbt_recipes.data matches 0 if score #found furnace_nbt_recipes.data matches 1 run function furnace_nbt_recipes:v1.9.1/technical/cook

# Disable cooking if needed (+ compability with ICY's NBT Smelting library)
execute if score #reset furnace_nbt_recipes.data matches 1 run data modify block ~ ~ ~ cooking_time_spent set value 0s
execute if score #reset furnace_nbt_recipes.data matches 1 if score #nbt_smelting.major load.status matches 1.. align xyz run scoreboard players set @e[tag=nbt_smelting.furnace.active,dx=-1,dy=-1,dz=-1] nbt_smelting.data 0

