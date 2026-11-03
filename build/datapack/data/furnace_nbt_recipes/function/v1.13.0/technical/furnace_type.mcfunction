
#> furnace_nbt_recipes:v1.13.0/technical/furnace_type
#
# @executed	as @e[tag=furnace_nbt_recipes.furnace] & at @s
#
# @within	furnace_nbt_recipes:v1.13.0/technical/main
#

scoreboard players set @s furnace_nbt_recipes.type 0
execute if block ~ ~ ~ blast_furnace run scoreboard players set @s furnace_nbt_recipes.type 1
execute if block ~ ~ ~ smoker run scoreboard players set @s furnace_nbt_recipes.type 2

