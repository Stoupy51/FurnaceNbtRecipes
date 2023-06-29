
advancement revoke @s only furnace_nbt_recipes:v1.1/placed_furnace
advancement revoke @s only furnace_nbt_recipes:v1.1/placed_blast_furnace
advancement revoke @s only furnace_nbt_recipes:v1.1/placed_smoker
execute if score FurnaceNbtRecipes load.status matches 11 run function furnace_nbt_recipes:v1.1/advancements/check_for_furnaces/look_all
