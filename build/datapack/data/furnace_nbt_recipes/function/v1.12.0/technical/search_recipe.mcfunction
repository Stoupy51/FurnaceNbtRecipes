
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

# Whether a vanilla recipe is disabled depends on the ingredient alone, like the custom recipes
scoreboard players set #reset furnace_nbt_recipes.data 0
execute if score #found furnace_nbt_recipes.data matches 0 at @s run function #furnace_nbt_recipes:v1/disable_cooking
scoreboard players operation #searched_reset furnace_nbt_recipes.data = #reset furnace_nbt_recipes.data
execute if score #found furnace_nbt_recipes.data matches 0 run return 0

# Room the output slot needs left for the library output: setting a count above the stack size clamps it to that size
item replace block -30000000 14 1610 container.4 from block -30000000 14 1610 container.3
item modify block -30000000 14 1610 container.4 {type:"minecraft:set_count",count:99}
execute store result score #lib_room furnace_nbt_recipes.data run data get block -30000000 14 1610 Items[{Slot:4b}].count

# The output compared with the item already sitting in the output slot, as one item in that slot
data modify storage furnace_nbt_recipes:main check.lib set from block -30000000 14 1610 Items[{Slot:3b}]
execute store result score #count furnace_nbt_recipes.data run data get storage furnace_nbt_recipes:main check.lib.count
scoreboard players operation #lib_room furnace_nbt_recipes.data -= #count furnace_nbt_recipes.data
data modify storage furnace_nbt_recipes:main check.lib merge value {count:1,Slot:2b}

