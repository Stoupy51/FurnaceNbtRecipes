
#> furnace_nbt_recipes:v1.9.1/load/resolve
#
# @within	#furnace_nbt_recipes:resolve
#

# If correct version, load the datapack
execute if score #furnace_nbt_recipes.major load.status matches 1 if score #furnace_nbt_recipes.minor load.status matches 9 if score #furnace_nbt_recipes.patch load.status matches 1 run function furnace_nbt_recipes:v1.9.1/load/main

