
#> furnace_nbt_recipes:v1.9.0/load_delayed
#
# @within	furnace_nbt_recipes:v1.9.0/load/confirm_load 2s replace
#			furnace_nbt_recipes:v1.9.0/load_delayed 2s replace
#

execute in minecraft:overworld run forceload add -30000000 1600
execute in minecraft:overworld run setblock -30000000 14 1610 yellow_shulker_box
execute unless loaded -30000000 14 1610 run schedule function furnace_nbt_recipes:v1.9.0/load_delayed 2s replace

