
#> furnace_nbt_recipes:v1.8.0/advancements/check_for_furnaces/try_place_marker
#
# @within	furnace_nbt_recipes:v1.8.0/advancements/check_for_furnaces/look_layer
#

execute align xyz positioned ~.5 ~ ~.5 unless entity @e[type=marker,dx=-1,dy=-1,dz=-1,tag=furnace_nbt_recipes.furnace] run summon marker ~ ~ ~ {Tags:["furnace_nbt_recipes.furnace"]}

