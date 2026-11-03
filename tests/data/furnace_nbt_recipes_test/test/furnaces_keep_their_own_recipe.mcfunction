# @template furnace_nbt_recipes_test:room
# @dummy ~ ~ ~
# @timeout 200
await score #furnace_nbt_recipes.loaded load.status matches 1
await block -30000000 14 1610 minecraft:yellow_shulker_box

setblock ~1 ~-1 ~2 minecraft:gold_block
item replace entity @s weapon.mainhand with minecraft:furnace
dummy @s use block ~1 ~-1 ~2
setblock ~2 ~-1 ~4 minecraft:gold_block
item replace entity @s weapon.mainhand with minecraft:blast_furnace
dummy @s use block ~2 ~-1 ~4
setblock ~3 ~-1 ~2 minecraft:gold_block
item replace entity @s weapon.mainhand with minecraft:furnace
dummy @s use block ~3 ~-1 ~2
item replace block ~1 ~ ~2 container.0 with minecraft:raw_iron[minecraft:custom_data={fnr_test:"a"}]
item replace block ~1 ~ ~2 container.1 with minecraft:coal
item replace block ~3 ~ ~2 container.0 with minecraft:raw_iron[minecraft:custom_data={fnr_test:"b"}]
item replace block ~3 ~ ~2 container.1 with minecraft:coal
item replace block ~2 ~ ~4 container.0 with minecraft:raw_iron[minecraft:custom_data={fnr_test:"a"}]
item replace block ~2 ~ ~4 container.1 with minecraft:coal

await items block ~1 ~ ~2 container.2 *
await items block ~3 ~ ~2 container.2 *
await items block ~2 ~ ~4 container.2 *
assert items block ~1 ~ ~2 container.2 minecraft:diamond[minecraft:custom_data={fnr_test:"a"}]
assert items block ~3 ~ ~2 container.2 minecraft:emerald[minecraft:custom_data={fnr_test:"b"}]
assert items block ~2 ~ ~4 container.2 minecraft:netherite_scrap[minecraft:custom_data={fnr_test:"a"}]
