
#> furnace_nbt_recipes:v1.9.0/load/main
#
# @within	furnace_nbt_recipes:v1.9.0/load/resolve
#

# Avoiding multiple executions of the same load function
execute unless score #furnace_nbt_recipes.loaded load.status matches 1 run function furnace_nbt_recipes:v1.9.0/load/secondary

