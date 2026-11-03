# @template furnace_nbt_recipes_test:room
# @dummy ~ ~ ~
# @timeout 400
await score #furnace_nbt_recipes.loaded load.status matches 1
await block -30000000 14 1610 minecraft:yellow_shulker_box

item replace entity @s weapon.mainhand with minecraft:furnace
dummy @s use block ~3 ~-1 ~2
item replace block ~3 ~ ~2 container.0 with minecraft:raw_iron[minecraft:custom_data={fnr_test:"a"}] 2
item replace block ~3 ~ ~2 container.1 with minecraft:coal

await delay 150
assert not items block ~3 ~ ~2 container.2 *

await items block ~3 ~ ~2 container.2 *
assert items block ~3 ~ ~2 container.2 minecraft:diamond[minecraft:custom_data={fnr_test:"a"}]
assert data block ~3 ~ ~2 Items[{Slot:2b,count:1}]
assert data block ~3 ~ ~2 Items[{Slot:0b,id:"minecraft:raw_iron",count:1}]
