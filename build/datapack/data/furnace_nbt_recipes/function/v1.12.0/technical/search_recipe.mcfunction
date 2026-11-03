
#> furnace_nbt_recipes:v1.12.0/technical/search_recipe
#
# @executed	in minecraft:overworld
#
# @within	furnace_nbt_recipes:v1.12.0/technical/main [ in minecraft:overworld ]
#

# The recipes write their output in the shulker box, which keeps it until the furnace cooks
scoreboard players set #found furnace_nbt_recipes.data 0
data modify block -30000000 14 1610 Items set from storage furnace_nbt_recipes:main furnace.Items
execute positioned -30000000 14 1610 run function furnace_nbt_recipes:v1.12.0/technical/call_recipes
scoreboard players operation #searched_found furnace_nbt_recipes.data = #found furnace_nbt_recipes.data

# The output compared with the item already sitting in the output slot, count and slot aside
data modify storage furnace_nbt_recipes:main check.lib set from block -30000000 14 1610 Items[{Slot:3b}]
data remove storage furnace_nbt_recipes:main check.lib.count
data remove storage furnace_nbt_recipes:main check.lib.Slot

