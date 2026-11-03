# @template furnace_nbt_recipes_test:room
# @dummy ~ ~ ~
# @timeout 200
await score #furnace_nbt_recipes.loaded load.status matches 1
await block -30000000 14 1610 minecraft:yellow_shulker_box

summon minecraft:item_display ~2.5 ~.5 ~2.5 {Tags:["furnace_nbt_recipes.furnace","furnace_nbt_recipes_test.block"]}
scoreboard players set @e[tag=furnace_nbt_recipes_test.block,distance=..8] furnace_nbt_recipes.speed 8000
item replace entity @s weapon.mainhand with minecraft:furnace
dummy @s use block ~2 ~-1 ~2
assert block ~2 ~ ~2 minecraft:furnace
execute positioned ~2.5 ~.5 ~2.5 run assert not entity @e[type=marker,distance=..1]

item replace block ~2 ~ ~2 container.0 with minecraft:raw_iron[minecraft:custom_data={fnr_test:"a"}]
item replace block ~2 ~ ~2 container.1 with minecraft:coal
await items block ~2 ~ ~2 container.2 minecraft:diamond[minecraft:custom_data={fnr_test:"a"}]
execute positioned ~2.5 ~.5 ~2.5 run assert not entity @e[type=marker,distance=..1]
