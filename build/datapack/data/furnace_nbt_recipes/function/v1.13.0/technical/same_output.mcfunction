
#> furnace_nbt_recipes:v1.13.0/technical/same_output
#
# @executed	as @e[tag=furnace_nbt_recipes.furnace] & at @s
#
# @within	furnace_nbt_recipes:v1.13.0/technical/main
#

execute store result score #count furnace_nbt_recipes.data run data get storage furnace_nbt_recipes:main furnace.Items[{Slot:2b}].count
execute if score #count furnace_nbt_recipes.data > #lib_room furnace_nbt_recipes.data run return run scoreboard players set #reset furnace_nbt_recipes.data 1

# Given the count search_recipe gave the library output, the output slot item equals it only when both stack
data modify storage furnace_nbt_recipes:main output set from storage furnace_nbt_recipes:main furnace.Items[{Slot:2b}]
data modify storage furnace_nbt_recipes:main output.count set value 1
execute store success score #reset furnace_nbt_recipes.data run data modify storage furnace_nbt_recipes:main output set from storage furnace_nbt_recipes:main check.lib

