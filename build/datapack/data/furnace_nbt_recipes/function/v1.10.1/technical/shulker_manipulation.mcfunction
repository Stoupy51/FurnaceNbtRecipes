
#> furnace_nbt_recipes:v1.10.1/technical/shulker_manipulation
#
# @executed	in minecraft:overworld
#
# @within	furnace_nbt_recipes:v1.10.1/technical/cook [ in minecraft:overworld ]
#

## Output manipulation
# Get if the output item is already in the furnace
scoreboard players set #success furnace_nbt_recipes.data 0
execute store result score #success furnace_nbt_recipes.data unless data storage furnace_nbt_recipes:main furnace.Items[{Slot:2b}]

# If there is no output item, then move the library output to the furnace
execute if score #success furnace_nbt_recipes.data matches 1 run data modify block -30000000 14 1610 Items[{Slot:3b}].Slot set value 2b
execute if score #success furnace_nbt_recipes.data matches 1 run data modify storage furnace_nbt_recipes:main furnace.Items append from block -30000000 14 1610 Items[{Slot:2b}]

# Else, increment count based on the library output count
execute if score #success furnace_nbt_recipes.data matches 0 store result score #lib_count furnace_nbt_recipes.data run data get block -30000000 14 1610 Items[{Slot:3b}].count
execute if score #success furnace_nbt_recipes.data matches 0 store result score #furnace_count furnace_nbt_recipes.data run data get storage furnace_nbt_recipes:main furnace.Items[{Slot:2b}].count
execute if score #success furnace_nbt_recipes.data matches 0 run scoreboard players operation #lib_count furnace_nbt_recipes.data += #furnace_count furnace_nbt_recipes.data
execute if score #success furnace_nbt_recipes.data matches 0 store result storage furnace_nbt_recipes:main furnace.Items[{Slot:2b}].count byte 1 run scoreboard players get #lib_count furnace_nbt_recipes.data

## Extra
# Consume one item in the input and reset cooking time
execute store result score #count furnace_nbt_recipes.data run data get storage furnace_nbt_recipes:main input.count
scoreboard players remove #count furnace_nbt_recipes.data 1
execute if score #count furnace_nbt_recipes.data matches 1.. store result storage furnace_nbt_recipes:main furnace.Items[{Slot:0b}].count byte 1 run scoreboard players get #count furnace_nbt_recipes.data
execute if score #count furnace_nbt_recipes.data matches 0 run data remove storage furnace_nbt_recipes:main furnace.Items[{Slot:0b}]
scoreboard players set #reset furnace_nbt_recipes.data 1

