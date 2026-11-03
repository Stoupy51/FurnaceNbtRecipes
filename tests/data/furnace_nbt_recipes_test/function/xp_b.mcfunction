execute store result score #count furnace_nbt_recipes_test.data run data get storage furnace_nbt_recipes:main furnace.RecipesUsed."furnace_nbt_recipes_test:b"
scoreboard players add #count furnace_nbt_recipes_test.data 1
execute store result block ~ ~ ~ RecipesUsed."furnace_nbt_recipes_test:b" int 1 run scoreboard players get #count furnace_nbt_recipes_test.data
