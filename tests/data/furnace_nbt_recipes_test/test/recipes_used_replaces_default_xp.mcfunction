# @template furnace_nbt_recipes_test:room
# @dummy ~ ~ ~
# @timeout 200
await score #furnace_nbt_recipes.loaded load.status matches 1
await block -30000000 14 1610 minecraft:yellow_shulker_box

setblock ~1 ~-1 ~2 minecraft:gold_block
item replace entity @s weapon.mainhand with minecraft:furnace
dummy @s use block ~1 ~-1 ~2
item replace block ~1 ~ ~2 container.0 with minecraft:raw_iron[minecraft:custom_data={fnr_test:"b"}]
item replace block ~1 ~ ~2 container.1 with minecraft:coal
await items block ~1 ~ ~2 container.2 *
assert data block ~1 ~ ~2 RecipesUsed."furnace_nbt_recipes_test:b"
assert not data block ~1 ~ ~2 RecipesUsed."furnace_nbt_recipes:xp/1.0"
