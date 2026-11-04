# @template furnace_nbt_recipes_test:room
# @dummy ~ ~ ~
# @timeout 200
await score #furnace_nbt_recipes.loaded load.status matches 1
await block -30000000 14 1610 minecraft:yellow_shulker_box

setblock ~1 ~-1 ~2 minecraft:gold_block
item replace entity @s weapon.mainhand with minecraft:furnace
dummy @s use block ~1 ~-1 ~2
item replace block ~1 ~ ~2 container.0 with minecraft:raw_iron[minecraft:custom_data={fnr_test:"a"}]
item replace block ~1 ~ ~2 container.1 with minecraft:recovery_compass

data modify block ~1 ~ ~2 lit_time_remaining set value 200
assert block ~1 ~ ~2 minecraft:furnace[lit=false]

await items block ~1 ~ ~2 container.2 minecraft:diamond[minecraft:custom_data={fnr_test:"a"}]
