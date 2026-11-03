# @template furnace_nbt_recipes_test:room
# @dummy ~ ~ ~
# @timeout 400
await score #furnace_nbt_recipes.loaded load.status matches 1
await block -30000000 14 1610 minecraft:yellow_shulker_box

item replace entity @s weapon.mainhand with minecraft:furnace
dummy @s use block ~1 ~-1 ~2
item replace entity @s weapon.mainhand with minecraft:furnace
dummy @s use block ~3 ~-1 ~2
item replace block ~1 ~ ~2 container.0 with minecraft:raw_copper[minecraft:custom_data={fnr_test:"blocked"}]
item replace block ~1 ~ ~2 container.1 with minecraft:coal
item replace block ~3 ~ ~2 container.0 with minecraft:raw_copper
item replace block ~3 ~ ~2 container.1 with minecraft:coal

await items block ~3 ~ ~2 container.2 minecraft:copper_ingot
await delay 40
assert not items block ~1 ~ ~2 container.2 *
assert items block ~1 ~ ~2 container.0 minecraft:raw_copper
