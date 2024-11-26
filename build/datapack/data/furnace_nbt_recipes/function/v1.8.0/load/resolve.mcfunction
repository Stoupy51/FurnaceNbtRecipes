
#> furnace_nbt_recipes:v1.8.0/load/resolve
#
# @within	#furnace_nbt_recipes:resolve
#

# If correct version, load the datapack
execute if score #furnace_nbt_recipes.major load.status matches 1 if score #furnace_nbt_recipes.minor load.status matches 8 if score #furnace_nbt_recipes.patch load.status matches 0 run function furnace_nbt_recipes:v1.8.0/load/main

