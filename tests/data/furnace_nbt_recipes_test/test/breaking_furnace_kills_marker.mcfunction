# @template furnace_nbt_recipes_test:room
# @dummy ~ ~ ~
# @timeout 200
await score #furnace_nbt_recipes.loaded load.status matches 1
await block -30000000 14 1610 minecraft:yellow_shulker_box

item replace entity @s weapon.mainhand with minecraft:furnace
dummy @s use block ~3 ~-1 ~2
execute positioned ~3.5 ~.5 ~2.5 run assert entity @e[type=marker,tag=furnace_nbt_recipes.furnace,distance=..0.75]
dummy @s mine ~3 ~ ~2
await delay 2
execute positioned ~3.5 ~.5 ~2.5 run assert not entity @e[type=marker,distance=..0.75]
