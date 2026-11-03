# @template furnace_nbt_recipes_test:room
# @dummy ~ ~ ~
# @timeout 200
await score #furnace_nbt_recipes.loaded load.status matches 1
await block -30000000 14 1610 minecraft:yellow_shulker_box

item replace entity @s weapon.mainhand with minecraft:furnace
dummy @s use block ~3 ~-1 ~2
item replace block ~3 ~ ~2 container.0 with minecraft:raw_iron[minecraft:custom_data={fnr_test:"a"}]
item replace block ~3 ~ ~2 container.1 with minecraft:coal

await delay 60
assert data block ~3 ~ ~2 {cooking_total_time:30000}
execute store result score #arrow furnace_nbt_recipes_test.data run data get block ~3 ~ ~2 cooking_time_spent
assert score #arrow furnace_nbt_recipes_test.data matches 6000..10500
await delay 40
execute store result score #arrow furnace_nbt_recipes_test.data run data get block ~3 ~ ~2 cooking_time_spent
assert score #arrow furnace_nbt_recipes_test.data matches 12000..16500
