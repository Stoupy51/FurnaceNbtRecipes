
# ruff: noqa: E501
# Imports
from beet import Context
from stewbeet import write_versioned_function


# Setup technical functions
def setup_technical_functions(ctx: Context) -> None:
	ns: str = ctx.project_id
	version: str = ctx.project_version

	write_versioned_function("nbt_smelting_compatibility/call_recipes", f"""
## Special compatibility with ICY's NBT Smelting
#define storage nbt_smelting:io

# Copy the input item to the storage and remove the output item
data modify storage nbt_smelting:io item set from storage {ns}:main input
item replace block ~ ~ ~ container.2 with air

# Depending on the type of furnace, we need to use a different function
execute if score #type {ns}.data matches 0 run function #nbt_smelting:v1/furnace
execute if score #type {ns}.data matches 1 run function #nbt_smelting:v1/blast_furnace
execute if score #type {ns}.data matches 2 run function #nbt_smelting:v1/smoker

# Copy ICY library's output to my output & remove the input storage
item replace block ~ ~ ~ container.3 from block ~ ~ ~ container.2
data remove storage nbt_smelting:io item

# If the furnace is not empty, we found a recipe
execute if data block ~ ~ ~ Items[{{Slot:2b}}] run scoreboard players set #found {ns}.data 1
""")

	write_versioned_function("technical/call_recipes", f"""
# Switch case on furnace type
execute if score #type {ns}.data matches 0 run function #{ns}:v1/smelting_recipes
execute if score #type {ns}.data matches 1 run function #{ns}:v1/blasting_recipes
execute if score #type {ns}.data matches 2 run function #{ns}:v1/smoking_recipes

# Special compatibility with ICY's NBT Smelting
execute if score #found {ns}.data matches 0 if score #nbt_smelting.major load.status matches 1.. run function {ns}:v{version}/nbt_smelting_compatibility/call_recipes
""")

	write_versioned_function("technical/cook", f"""
# Take the library output and consume one input item
execute in minecraft:overworld run function {ns}:v{version}/technical/shulker_manipulation

# If shulker manipulation was not done, exit function
execute if score #reset {ns}.data matches 0 run return 0

# Apply new storage values (because shulker manipulation was done)
data modify block ~ ~ ~ Items set from storage {ns}:main furnace.Items

# The output was taken from the shulker box, and a loot table may roll another one for the next item
data remove storage {ns}:main searched

# Apply XP support
scoreboard players set #found {ns}.data 0
function #{ns}:v1/recipes_used
# A handler called through 'store result ... run function' sets no #found when its function returns nothing, so its write to RecipesUsed counts too
execute if score #found {ns}.data matches 0 store success score #found {ns}.data run data modify storage {ns}:main furnace.RecipesUsed set from block ~ ~ ~ RecipesUsed
execute if score #found {ns}.data matches 0 run function {ns}:v{version}/technical/default_xp

# Restart the cooking clock, handing the furnace back its real cooking time
execute if score @s {ns}.intended matches 1.. store result block ~ ~ ~ cooking_total_time int 1 run scoreboard players get @s {ns}.intended
data modify block ~ ~ ~ cooking_time_spent set value 0
scoreboard players set @s {ns}.progress 0
scoreboard players set @s {ns}.partial 0
scoreboard players reset @s {ns}.stall_time
""")

	write_versioned_function("technical/clock", f"""
## Own the cooking clock, vanilla would otherwise complete the recipe on its own
# Adopt the cooking time the game computed for this recipe, it accounts for the fuel speed multiplier
scoreboard players add @s {ns}.intended 0
scoreboard players add @s {ns}.progress 0
execute unless score @s {ns}.speed matches 1.. run scoreboard players set @s {ns}.speed 1000
execute unless score #total_time {ns}.data = #held {ns}.data run function {ns}:v{version}/technical/clock_reset

# Without a known duration, leave the furnace alone until it lights again and the game computes one
execute unless score @s {ns}.intended matches 1.. run return 0

# Advance like vanilla does: forward while lit, backward once the fire is out
execute unless score #lit {ns}.data matches 0 run scoreboard players operation @s {ns}.partial += @s {ns}.speed
scoreboard players operation #gain {ns}.data = @s {ns}.partial
scoreboard players operation #gain {ns}.data /= #1000 {ns}.data
scoreboard players operation @s {ns}.progress += #gain {ns}.data
scoreboard players operation #gain {ns}.data *= #1000 {ns}.data
scoreboard players operation @s {ns}.partial -= #gain {ns}.data
execute if score #lit {ns}.data matches 0 run scoreboard players remove @s {ns}.progress 2
execute if score @s {ns}.progress matches ..0 run scoreboard players set @s {ns}.progress 0
execute if score @s {ns}.progress matches ..0 run scoreboard players set @s {ns}.partial 0

# Hold the furnace clock, scaling our progress onto it so the progress arrow keeps its real ratio
scoreboard players operation #write {ns}.data = #held {ns}.data
scoreboard players operation #write {ns}.data /= @s {ns}.intended
scoreboard players operation #write {ns}.data *= @s {ns}.progress
execute unless score #total_time {ns}.data = #held {ns}.data store result block ~ ~ ~ cooking_total_time int 1 run scoreboard players get #held {ns}.data

# Vanilla moves the clock by one every tick, so ours is only written once the arrow would show another of its 24 pixels, and always on the last one, where vanilla would otherwise complete the recipe
scoreboard players operation #pixel {ns}.data = #write {ns}.data
scoreboard players operation #pixel {ns}.data /= #pixel_time {ns}.data
scoreboard players operation #shown_pixel {ns}.data = #cook_time {ns}.data
scoreboard players operation #shown_pixel {ns}.data /= #pixel_time {ns}.data
execute if score #shown_pixel {ns}.data matches 23.. run scoreboard players set #shown_pixel {ns}.data -1
execute unless score #shown_pixel {ns}.data = #pixel {ns}.data store result block ~ ~ ~ cooking_time_spent int 1 run scoreboard players get #write {ns}.data

# Cook once the recipe got its full duration
execute if score @s {ns}.progress >= @s {ns}.intended run function {ns}:v{version}/technical/cook
""")

	write_versioned_function("technical/vanilla_clock", f"""
# Vanilla already adds one tick of progress, add what the configured speed gives on top of it
scoreboard players operation @s {ns}.partial += @s {ns}.speed
scoreboard players remove @s {ns}.partial 1000
scoreboard players operation #gain {ns}.data = @s {ns}.partial
scoreboard players operation #gain {ns}.data /= #1000 {ns}.data
scoreboard players operation @s {ns}.partial %= #1000 {ns}.data
scoreboard players operation #cook_time {ns}.data += #gain {ns}.data

# Stay one tick short of completion, vanilla completes the recipe on its own next tick
scoreboard players remove #total_time {ns}.data 1
execute if score #cook_time {ns}.data > #total_time {ns}.data run scoreboard players operation #cook_time {ns}.data = #total_time {ns}.data
execute store result block ~ ~ ~ cooking_time_spent int 1 run scoreboard players get #cook_time {ns}.data
""")

	write_versioned_function("technical/clock_reset", f"""
# A cooking time as long as the held one is a leftover hold, not a duration a recipe asked for
scoreboard players set @s {ns}.intended 0
execute if score #total_time {ns}.data < #held {ns}.data run scoreboard players operation @s {ns}.intended = #total_time {ns}.data
execute if score #total_time {ns}.data < #held {ns}.data run scoreboard players operation @s {ns}.progress = #cook_time {ns}.data
scoreboard players set @s {ns}.partial 0
""")

	write_versioned_function("technical/default_xp", f"""
scoreboard players set #count {ns}.data 0
execute store result score #count {ns}.data run data get storage {ns}:main furnace.RecipesUsed."{ns}:xp/1.0"
scoreboard players add #count {ns}.data 1
execute store result block ~ ~ ~ RecipesUsed."{ns}:xp/1.0" int 1 run scoreboard players get #count {ns}.data
scoreboard players reset #count {ns}.data
""")

	write_versioned_function("technical/main", f"""
# Work while the fire burns, and while there is fuel left to light it
execute store result score #lit {ns}.data if block ~ ~ ~ #{ns}:furnaces[lit=true]
execute if score #lit {ns}.data matches 0 unless items block ~ ~ ~ container.1 * run return 0

# Copy furnace nbt once, the checks below read this copy
data modify storage {ns}:main furnace set from block ~ ~ ~

# A tracked furnace keeps its block, so its type is read once, whatever entity tracks it
execute unless score @s {ns}.type matches 0.. run function {ns}:v{version}/technical/furnace_type
scoreboard players operation #type {ns}.data = @s {ns}.type


## Storage manipulation
# Copy some nbt into scores
scoreboard players set #total_time {ns}.data 0
execute store result score #cook_time {ns}.data run data get storage {ns}:main furnace.cooking_time_spent
execute store result score #total_time {ns}.data run data get storage {ns}:main furnace.cooking_total_time
data modify storage {ns}:main input set from storage {ns}:main furnace.Items[{{Slot:0b}}]

# Search the recipe only when the ingredient or the furnace type differs from the last search, whichever furnace ran it
data modify storage {ns}:main ingredient set from storage {ns}:main input
data remove storage {ns}:main ingredient.count
execute store result storage {ns}:main ingredient.furnace_type byte 1 run scoreboard players get #type {ns}.data
execute store success score #new_ingredient {ns}.data run data modify storage {ns}:main searched set from storage {ns}:main ingredient
execute if score #new_ingredient {ns}.data matches 1 in minecraft:overworld run function {ns}:v{version}/technical/search_recipe
scoreboard players operation #found {ns}.data = #searched_found {ns}.data
scoreboard players operation #reset {ns}.data = #searched_reset {ns}.data

## Disable cooking if not permitted (If no recipe is found and user conditions, or if the output slot holds another item or is full)
execute if score #found {ns}.data matches 1 if data storage {ns}:main furnace.Items[{{Slot:2b}}] run function {ns}:v{version}/technical/same_output

# Otherwise, continue
execute if score #reset {ns}.data matches 0 if score #found {ns}.data matches 1 if score #total_time {ns}.data matches 1.. run function {ns}:v{version}/technical/clock

# A vanilla recipe keeps the vanilla clock, so a furnace configured faster than 1000 gets its extra progress here
execute if score #reset {ns}.data matches 0 if score #found {ns}.data matches 0 if score @s {ns}.speed matches 1001.. if score #cook_time {ns}.data matches 1.. if score #total_time {ns}.data matches 1..29999 unless score #lit {ns}.data matches 0 run function {ns}:v{version}/technical/vanilla_clock

# The fire paces the cooking, so stalling only counts while it is out
execute unless score #lit {ns}.data matches 0 run scoreboard players reset @s {ns}.stall_time

# Track stalling: if recipe found but cooking_time_spent is 0, increment stall_time
execute if score #reset {ns}.data matches 0 if score #found {ns}.data matches 1 if score #cook_time {ns}.data matches 0 run scoreboard players add @s {ns}.stall_time 1

# Vanilla refuses to light while the output slot holds an item its own recipe cannot stack with, give it a free slot
execute if score #reset {ns}.data matches 0 if score #found {ns}.data matches 1 if entity @s[type=marker] if score @s {ns}.stall_time matches 5 if score #lit {ns}.data matches 0 if items block ~ ~ ~ container.1 * if items block ~ ~ ~ container.2 * run function {ns}:v{version}/technical/ignite

# Force smelting if stalled for too long (100 ticks)
execute if score #reset {ns}.data matches 0 if score #found {ns}.data matches 1 if score @s {ns}.stall_time matches 100.. run function {ns}:v{version}/technical/cook

# Disable cooking if needed (+ compability with ICY's NBT Smelting library)
execute if score #reset {ns}.data matches 1 unless score #cook_time {ns}.data matches 0 run data modify block ~ ~ ~ cooking_time_spent set value 0
execute if score #reset {ns}.data matches 1 if score #nbt_smelting.major load.status matches 1.. align xyz run scoreboard players set @e[tag=nbt_smelting.furnace.active,dx=-1,dy=-1,dz=-1] nbt_smelting.data 0
""")

	write_versioned_function("technical/destroy", f"""
execute if score @s {ns}.stashed matches 1 run function {ns}:v{version}/technical/drop_stash with entity @s data

# A marker is ours to remove, any other entity only stops being tracked
execute if entity @s[type=marker] run return run kill @s
tag @s remove {ns}.furnace
scoreboard players reset @s {ns}.speed
scoreboard players reset @s {ns}.intended
scoreboard players reset @s {ns}.progress
scoreboard players reset @s {ns}.partial
scoreboard players reset @s {ns}.stall_time
scoreboard players reset @s {ns}.type
""")

	write_versioned_function("technical/furnace_type", f"""
scoreboard players set @s {ns}.type 0
execute if block ~ ~ ~ blast_furnace run scoreboard players set @s {ns}.type 1
execute if block ~ ~ ~ smoker run scoreboard players set @s {ns}.type 2
""")

	write_versioned_function("technical/ignite", f"""
# Park the output item so that the furnace lights itself: it burns its own fuel and sets its own cooking speed
data modify entity @s data.stash set from storage {ns}:main furnace.Items[{{Slot:2b}}]
data remove block ~ ~ ~ Items[{{Slot:2b}}]
scoreboard players set @s {ns}.stashed 1

# Start from zero, the freed slot would otherwise let the vanilla recipe complete during that tick
data modify block ~ ~ ~ cooking_time_spent set value 0
""")

	write_versioned_function("technical/unstash", f"""
# The stash keeps its own Slot, appending it in a single command puts it straight back in the output slot
data modify block ~ ~ ~ Items append from entity @s data.stash
data remove entity @s data.stash
scoreboard players set @s {ns}.stashed 0
""")

	write_versioned_function("technical/drop_stash", f"""
$summon item ~ ~ ~ {{Item:$(stash)}}
""")

	write_versioned_function("technical/search_recipe", f"""
# The recipes write their output in the shulker box, which keeps it until the furnace cooks
scoreboard players set #found {ns}.data 0
data modify block -30000000 14 1610 Items set from storage {ns}:main furnace.Items
execute positioned -30000000 14 1610 run function {ns}:v{version}/technical/call_recipes
scoreboard players operation #searched_found {ns}.data = #found {ns}.data

# Whether a vanilla recipe is disabled depends on the ingredient alone, like the custom recipes
scoreboard players set #reset {ns}.data 0
execute if score #found {ns}.data matches 0 at @s run function #{ns}:v1/disable_cooking
scoreboard players operation #searched_reset {ns}.data = #reset {ns}.data
execute if score #found {ns}.data matches 0 run return 0

# Room the output slot needs left for the library output: setting a count above the stack size clamps it to that size
item replace block -30000000 14 1610 container.4 from block -30000000 14 1610 container.3
item modify block -30000000 14 1610 container.4 {{type:"minecraft:set_count",count:99}}
execute store result score #lib_room {ns}.data run data get block -30000000 14 1610 Items[{{Slot:4b}}].count

# The output compared with the item already sitting in the output slot, as one item in that slot
data modify storage {ns}:main check.lib set from block -30000000 14 1610 Items[{{Slot:3b}}]
execute store result score #count {ns}.data run data get storage {ns}:main check.lib.count
scoreboard players operation #lib_room {ns}.data -= #count {ns}.data
data modify storage {ns}:main check.lib merge value {{count:1,Slot:2b}}
""")

	write_versioned_function("technical/same_output", f"""
execute store result score #count {ns}.data run data get storage {ns}:main furnace.Items[{{Slot:2b}}].count
execute if score #count {ns}.data > #lib_room {ns}.data run return run scoreboard players set #reset {ns}.data 1

# Given the count search_recipe gave the library output, the output slot item equals it only when both stack
data modify storage {ns}:main output set from storage {ns}:main furnace.Items[{{Slot:2b}}]
data modify storage {ns}:main output.count set value 1
execute store success score #reset {ns}.data run data modify storage {ns}:main output set from storage {ns}:main check.lib
""")

	write_versioned_function("technical/shulker_manipulation", f"""
## Output manipulation
# Get if the output item is already in the furnace
scoreboard players set #success {ns}.data 0
execute store result score #success {ns}.data unless data storage {ns}:main furnace.Items[{{Slot:2b}}]

# If there is no output item, then move the library output to the furnace
execute if score #success {ns}.data matches 1 run data modify block -30000000 14 1610 Items[{{Slot:3b}}].Slot set value 2b
execute if score #success {ns}.data matches 1 run data modify storage {ns}:main furnace.Items append from block -30000000 14 1610 Items[{{Slot:2b}}]

# Else, increment count based on the library output count
execute if score #success {ns}.data matches 0 store result score #lib_count {ns}.data run data get block -30000000 14 1610 Items[{{Slot:3b}}].count
execute if score #success {ns}.data matches 0 store result score #furnace_count {ns}.data run data get storage {ns}:main furnace.Items[{{Slot:2b}}].count
execute if score #success {ns}.data matches 0 run scoreboard players operation #lib_count {ns}.data += #furnace_count {ns}.data
execute if score #success {ns}.data matches 0 store result storage {ns}:main furnace.Items[{{Slot:2b}}].count int 1 run scoreboard players get #lib_count {ns}.data

## Extra
# Consume one item in the input and reset cooking time
execute store result score #count {ns}.data run data get storage {ns}:main input.count
scoreboard players remove #count {ns}.data 1
execute if score #count {ns}.data matches 1.. store result storage {ns}:main furnace.Items[{{Slot:0b}}].count byte 1 run scoreboard players get #count {ns}.data
execute if score #count {ns}.data matches 0 run data remove storage {ns}:main furnace.Items[{{Slot:0b}}]
scoreboard players set #reset {ns}.data 1
""")

	write_versioned_function("technical/tick", f"""
# Destroy marker entity if furnace is destroyed, and stop execution
execute unless block ~ ~ ~ #{ns}:furnaces run return run function {ns}:v{version}/technical/destroy

# Give back the output item parked for the lighting tick
execute if score @s {ns}.stashed matches 1 unless data block ~ ~ ~ Items[{{Slot:2b}}] run function {ns}:v{version}/technical/unstash

# Nothing to cook
execute unless items block ~ ~ ~ container.0 * run return 0
function {ns}:v{version}/technical/main
""")

