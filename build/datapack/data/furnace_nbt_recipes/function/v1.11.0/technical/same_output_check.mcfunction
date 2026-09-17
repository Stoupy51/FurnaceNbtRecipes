
#> furnace_nbt_recipes:v1.11.0/technical/same_output_check
#
# @executed	as @e[type=marker,tag=furnace_nbt_recipes.furnace] & at @s
#
# @within	furnace_nbt_recipes:v1.11.0/technical/same_output with storage furnace_nbt_recipes:main check
#
# @args		lib (unknown)
#			fur (unknown)
#

$execute if data storage furnace_nbt_recipes:main check.fur$(lib) run scoreboard players add #same furnace_nbt_recipes.data 1
$execute if data storage furnace_nbt_recipes:main check.lib$(fur) run scoreboard players add #same furnace_nbt_recipes.data 1

