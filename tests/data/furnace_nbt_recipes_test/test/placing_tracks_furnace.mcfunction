# @template furnace_nbt_recipes_test:room
# @dummy ~ ~ ~
# @timeout 200
await score #furnace_nbt_recipes.loaded load.status matches 1
await block -30000000 14 1610 minecraft:yellow_shulker_box

setblock ~1 ~-1 ~2 minecraft:gold_block
item replace entity @s weapon.mainhand with minecraft:furnace
dummy @s use block ~1 ~-1 ~2
item replace entity @s weapon.mainhand with minecraft:furnace
dummy @s use block ~3 ~-1 ~2

execute positioned ~1.5 ~.5 ~2.5 store result score #markers furnace_nbt_recipes_test.data if entity @e[type=marker,tag=furnace_nbt_recipes.furnace,distance=..0.75]
assert score #markers furnace_nbt_recipes_test.data matches 1
execute positioned ~1.5 ~.5 ~2.5 run assert entity @e[type=marker,tag=furnace_nbt_recipes.furnace,distance=..0.75,scores={furnace_nbt_recipes.speed=8000}]
execute positioned ~3.5 ~.5 ~2.5 run assert entity @e[type=marker,tag=furnace_nbt_recipes.furnace,distance=..0.75,scores={furnace_nbt_recipes.speed=1000}]
