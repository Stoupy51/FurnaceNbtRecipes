
#> furnace_nbt_recipes:v1.11.0/advancements/check_for_furnaces/new_furnace
#
# @executed	align xyz & positioned ~.5 ~ ~.5
#
# @within	furnace_nbt_recipes:v1.11.0/advancements/check_for_furnaces/try_place_marker [ align xyz & positioned ~.5 ~ ~.5 ]
#

# A furnace is configured once, the tick it starts being tracked, so driving one costs nothing afterwards
tag @s add furnace_nbt_recipes.furnace
scoreboard players set @s furnace_nbt_recipes.speed 1000
function #furnace_nbt_recipes:v1/configure_furnace

