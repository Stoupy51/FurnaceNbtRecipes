
#> furnace_nbt_recipes:v1.12.0/technical/drop_stash
#
# @executed	as @e[tag=furnace_nbt_recipes.furnace] & at @s
#
# @within	furnace_nbt_recipes:v1.12.0/technical/destroy with entity @s data
#
# @args		stash (unknown)
#

$summon item ~ ~ ~ {Item:$(stash)}

