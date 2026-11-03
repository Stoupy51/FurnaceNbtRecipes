# @template furnace_nbt_recipes_test:room
# @dummy ~ ~ ~
# @timeout 200
await score #furnace_nbt_recipes.loaded load.status matches 1
await block -30000000 14 1610 minecraft:yellow_shulker_box

summon minecraft:item_display ~2.5 ~.5 ~2.5 {Tags:["furnace_nbt_recipes.furnace","furnace_nbt_recipes_test.block"]}
scoreboard players set @e[tag=furnace_nbt_recipes_test.block,distance=..8] furnace_nbt_recipes.speed 8000
setblock ~2 ~ ~2 minecraft:furnace
dummy @s mine ~2 ~ ~2
await delay 2
execute positioned ~2.5 ~.5 ~2.5 run assert entity @e[tag=furnace_nbt_recipes_test.block,distance=..0.75]
execute positioned ~2.5 ~.5 ~2.5 run assert not entity @e[tag=furnace_nbt_recipes.furnace,distance=..0.75]
execute positioned ~2.5 ~.5 ~2.5 run assert not entity @e[tag=furnace_nbt_recipes_test.block,distance=..0.75,scores={furnace_nbt_recipes.speed=0..}]
