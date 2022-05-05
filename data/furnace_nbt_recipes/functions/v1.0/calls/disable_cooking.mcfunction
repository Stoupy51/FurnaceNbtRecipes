
##Called by function tag #furnace_nbt_recipes:v1.0/disable_cooking
##In this function, you should only disable recipes that you added yourself.
##For instance, barrel and command_block recipes are added by default
##in the furnace_nbt_recipes/recipes/ folder.

execute if score #reset furnace_nbt_recipes.data matches 0 store success score #reset furnace_nbt_recipes.data if data storage furnace_nbt_recipes:main input{id:"minecraft:barrel"}
execute if score #reset furnace_nbt_recipes.data matches 0 store success score #reset furnace_nbt_recipes.data if data storage furnace_nbt_recipes:main input{id:"minecraft:command_block"}

