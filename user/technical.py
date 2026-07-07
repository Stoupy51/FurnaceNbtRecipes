
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
# Choose type of furnace and do recipes
execute if score #type {ns}.data matches 0 if score #cook_time {ns}.data matches 190.. in minecraft:overworld run function {ns}:v{version}/technical/shulker_manipulation
execute unless score #type {ns}.data matches 0 if score #cook_time {ns}.data matches 90.. in minecraft:overworld run function {ns}:v{version}/technical/shulker_manipulation

# If shulker manipulation was not done, exit function
execute if score #reset {ns}.data matches 0 run return 0

# Apply new storage values (because shulker manipulation was done)
data modify block ~ ~ ~ Items set from storage {ns}:main furnace.Items

# Apply XP support
scoreboard players set #found {ns}.data 0
function #{ns}:v1/recipes_used
execute if score #found {ns} matches 0 run function {ns}:v{version}/technical/default_xp

# Reset stall_time
scoreboard players reset @s {ns}.stall_time

""")

	write_versioned_function("technical/default_xp", f"""
scoreboard players set #count {ns}.data 0
execute store result score #count {ns}.data run data get storage {ns}:main furnace.RecipesUsed."{ns}:xp/1.0"
scoreboard players add #count {ns}.data 1
execute store result block ~ ~ ~ RecipesUsed."{ns}:xp/1.0" int 1 run scoreboard players get #count {ns}.data
scoreboard players reset #count {ns}.data
""")

	write_versioned_function("technical/main", f"""
# Copy furnace nbt
data modify storage {ns}:main furnace set from block ~ ~ ~

# Get what type of furnace is being used
scoreboard players set #type {ns}.data 0
execute store result score #type {ns}.data if block ~ ~ ~ blast_furnace
execute if score #type {ns}.data matches 0 if block ~ ~ ~ blast_furnace run scoreboard players set #type {ns}.data 1
execute if score #type {ns}.data matches 0 if block ~ ~ ~ smoker run scoreboard players set #type {ns}.data 2


## Storage manipulation
# Copy some nbt into scores
execute store result score #cook_time {ns}.data run data get storage {ns}:main furnace.cooking_time_spent
execute store result score #output_cmd {ns}.data run data get storage {ns}:main furnace.Items[{{Slot:2b}}].components."minecraft:custom_model_data"
data modify storage {ns}:main input set from storage {ns}:main furnace.Items[{{Slot:0b}}]

# Check if there is a recipe found
scoreboard players set #found {ns}.data 0
execute in minecraft:overworld run data modify block -30000000 14 1610 Items set from storage {ns}:main furnace.Items
execute in minecraft:overworld positioned -30000000 14 1610 run function {ns}:v{version}/technical/call_recipes

# Get in a score the expected Custom Model Data
execute store result score #excepted_cmd {ns}.data in minecraft:overworld run data get block -30000000 14 1610 Items[{{Slot:3b}}].components."minecraft:custom_model_data"


## Disable cooking if not permitted (If no recipe is found and user conditions, or if the output is not the expected one)
scoreboard players set #reset {ns}.data 0
execute if score #found {ns}.data matches 0 run function #{ns}:v1/disable_cooking
execute if score #reset {ns}.data matches 0 store success score #reset {ns}.data unless score #output_cmd {ns}.data matches 0 unless score #output_cmd {ns}.data = #excepted_cmd {ns}.data

# Otherwise, continue
execute if score #reset {ns}.data matches 0 if score #found {ns}.data matches 1 run function {ns}:v{version}/technical/cook

# Track stalling: if recipe found but cooking_time_spent is 0, increment stall_time
execute if score #reset {ns}.data matches 0 if score #found {ns}.data matches 1 if score #cook_time {ns}.data matches 0 run scoreboard players add @s {ns}.stall_time 1

# Force smelting if stalled for too long (200 ticks for furnace, 100 ticks for blast/smoker)
execute if score #reset {ns}.data matches 0 if score #found {ns}.data matches 1 if score @s {ns}.stall_time matches 100.. run scoreboard players operation #cook_time {ns}.data = @s {ns}.stall_time
execute if score #reset {ns}.data matches 0 if score #found {ns}.data matches 1 if score @s {ns}.stall_time matches 100.. run function {ns}:v{version}/technical/cook

# Disable cooking if needed (+ compability with ICY's NBT Smelting library)
execute if score #reset {ns}.data matches 1 run data modify block ~ ~ ~ cooking_time_spent set value 0s
execute if score #reset {ns}.data matches 1 if score #nbt_smelting.major load.status matches 1.. align xyz run scoreboard players set @e[tag=nbt_smelting.furnace.active,dx=-1,dy=-1,dz=-1] nbt_smelting.data 0

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
execute if score #success {ns}.data matches 0 store result storage {ns}:main furnace.Items[{{Slot:2b}}].count byte 1 run scoreboard players get #lib_count {ns}.data

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
execute unless block ~ ~ ~ #{ns}:furnaces run return run kill @s

# Else, run main function if furnace is cooking
execute unless data block ~ ~ ~ {{cooking_time_spent:0s}} run return run function {ns}:v{version}/technical/main

# If furnace has items but cooking_time_spent is 0, and there is still fuel, run main to check for stalling
execute if data block ~ ~ ~ Items[{{Slot:0b}}] if data block ~ ~ ~ Items[{{Slot:1b}}] run function {ns}:v{version}/technical/main

""")

