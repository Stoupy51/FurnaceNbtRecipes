
advancement revoke @s only furnace_nbt_recipes:VERSION/placed_furnace
execute if score #furnace_nbt_recipes.major load.status matches 1 if score #furnace_nbt_recipes.minor load.status matches 7 if score #furnace_nbt_recipes.patch load.status matches 0 run function furnace_nbt_recipes:VERSION/advancements/check_for_furnaces/look_all
