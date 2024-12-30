
#> furnace_nbt_recipes:v1.9.0/nbt_smelting_compatibility/call_recipes
#
# @within	furnace_nbt_recipes:v1.9.0/technical/call_recipes
#

## Special compatibility with ICY's NBT Smelting
#define storage nbt_smelting:io

# Copy the input item to the storage and remove the output item
data modify storage nbt_smelting:io item set from storage furnace_nbt_recipes:main input
item replace block ~ ~ ~ container.2 with air

# Depending on the type of furnace, we need to use a different function
execute if score #type furnace_nbt_recipes.data matches 0 run function #nbt_smelting:v1/furnace
execute if score #type furnace_nbt_recipes.data matches 1 run function #nbt_smelting:v1/blast_furnace
execute if score #type furnace_nbt_recipes.data matches 2 run function #nbt_smelting:v1/smoker

# Copy ICY library's output to my output & remove the input storage
item replace block ~ ~ ~ container.3 from block ~ ~ ~ container.2
data remove storage nbt_smelting:io item

# If the furnace is not empty, we found a recipe
execute if data block ~ ~ ~ Items[{Slot:2b}] run scoreboard players set #found furnace_nbt_recipes.data 1

