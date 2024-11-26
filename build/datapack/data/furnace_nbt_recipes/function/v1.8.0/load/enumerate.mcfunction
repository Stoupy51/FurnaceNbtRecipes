
#> furnace_nbt_recipes:v1.8.0/load/enumerate
#
# @within	#furnace_nbt_recipes:enumerate
#

# If current major is too low, set it to the current major
execute unless score #furnace_nbt_recipes.major load.status matches 1.. run scoreboard players set #furnace_nbt_recipes.major load.status 1

# If current minor is too low, set it to the current minor (only if major is correct)
execute if score #furnace_nbt_recipes.major load.status matches 1 unless score #furnace_nbt_recipes.minor load.status matches 8.. run scoreboard players set #furnace_nbt_recipes.minor load.status 8

# If current patch is too low, set it to the current patch (only if major and minor are correct)
execute if score #furnace_nbt_recipes.major load.status matches 1 if score #furnace_nbt_recipes.minor load.status matches 8 unless score #furnace_nbt_recipes.patch load.status matches 0.. run scoreboard players set #furnace_nbt_recipes.patch load.status 0

