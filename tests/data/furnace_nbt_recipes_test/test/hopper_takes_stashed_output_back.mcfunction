# @template furnace_nbt_recipes_test:room
# @dummy ~ ~ ~
# @timeout 400
await score #furnace_nbt_recipes.loaded load.status matches 1
await block -30000000 14 1610 minecraft:yellow_shulker_box

setblock ~1 ~-1 ~2 minecraft:gold_block
item replace entity @s weapon.mainhand with minecraft:furnace
dummy @s use block ~1 ~-1 ~2
setblock ~1 ~-1 ~1 minecraft:redstone_block
setblock ~1 ~-1 ~2 minecraft:hopper[facing=east]
setblock ~2 ~-1 ~2 minecraft:chest
setblock ~1 ~1 ~2 minecraft:hopper[facing=down]
item replace block ~1 ~1 ~2 container.0 with minecraft:raw_iron[minecraft:custom_data={fnr_test:"a"}] 2
item replace block ~1 ~ ~2 container.2 with minecraft:diamond[minecraft:custom_data={fnr_test:"a"}]
item replace block ~1 ~ ~2 container.1 with minecraft:coal

await data block ~1 ~ ~2 Items[{Slot:2b,count:3}]
setblock ~1 ~-1 ~1 minecraft:stone
await data block ~2 ~-1 ~2 Items[{id:"minecraft:diamond",count:3}]
await delay 10
assert not data block ~2 ~-1 ~2 Items[1]
assert not data block ~1 ~ ~2 Items[{Slot:0b}]
assert not data block ~1 ~ ~2 Items[{Slot:2b}]
assert not data block ~1 ~1 ~2 Items[0]
execute positioned ~1.5 ~.5 ~2.5 run assert not entity @e[type=marker,distance=..0.75,scores={furnace_nbt_recipes.stashed=1}]
