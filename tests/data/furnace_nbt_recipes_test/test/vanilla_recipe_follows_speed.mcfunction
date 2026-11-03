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
item replace block ~1 ~ ~2 container.0 with minecraft:raw_gold
item replace block ~1 ~ ~2 container.1 with minecraft:coal
item replace block ~3 ~ ~2 container.0 with minecraft:raw_gold
item replace block ~3 ~ ~2 container.1 with minecraft:coal

await delay 50
assert items block ~1 ~ ~2 container.2 minecraft:gold_ingot
assert not items block ~1 ~ ~2 container.0 *
assert not items block ~3 ~ ~2 container.2 *
assert items block ~3 ~ ~2 container.0 minecraft:raw_gold
