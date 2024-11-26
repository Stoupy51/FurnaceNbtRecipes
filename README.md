# 📖 Furnace NBT Recipes

[![GitHub](https://img.shields.io/github/v/release/Stoupy51/FurnaceNbtRecipes?logo=github&label=GitHub)](https://github.com/Stoupy51/FurnaceNbtRecipes/releases/latest)
[![Smithed](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fapi.smithed.dev%2Fv2%2Fpacks%2Ffurnace_nbt_recipes%2Fmeta&query=%24.stats.downloads.total&logo=data%3Aimage%2Fsvg%2Bxml%3Bbase64%2CPHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDQgNCIgeG1sbnM6dj0iaHR0cHM6Ly92ZWN0YS5pby9uYW5vIj48cGF0aCBkPSJNLjczNy44NTlsLjg4Ny0uMjg1Yy4wOTktLjAzMi4yMDUtLjAzMi4zMDQgMGwxLjMzNS40MjktMS4wNC4zMzR6bS0uMTk1LjE4OXYuNDg3YzAgLjEwNS4wNjguMTk5LjE2OC4yMzFsMS41MTQuNDg3TDMuMjkgMS45MWMuMS0uMDMyLjE2OC0uMTI2LjE2OC0uMjMxdi0uNDg3bC0xLjIzNC4zOTF6bS44NTkgMS4xOWwuODIzLjI2LjQxMi0uMTI3di4zNzlsLS40MTIuMTMyLS44MjMtLjI2NHptLS40NDguNTA1di4yOTlsMS4yNzIuNDA4LjgyMy0uMjY0di0uM2wtLjgyMy4yNTl6IiBwYWludC1vcmRlcj0ic3Ryb2tlIGZpbGwgbWFya2VycyIgZmlsbD0iIzFiNDhjNCIvPjwvc3ZnPg%3D%3D&logoColor=224bbb&label=Smithed&labelColor=black&color=224bbb)](https://smithed.net/packs/furnace_nbt_recipes)
[![Modrinth](https://img.shields.io/modrinth/dt/furnace_nbt_recipes?logo=modrinth&label=Modrinth)](https://modrinth.com/datapack/furnace_nbt_recipes)
[![Discord](https://img.shields.io/discord/1216400498488377467?label=Discord&logo=discord)](https://discord.gg/anxzu6rA9F)
[![Python Datapack](https://img.shields.io/github/v/release/Stoupy51/python_datapack?logo=github&label=Python%20Datapack)](https://github.com/Stoupy51/PythonDatapackTemplate)

🔥 Minecraft datapack library for handling custom furnace recipes with advanced NBT support!<br>
Enables creation of complex smelting recipes using NBT tags / components. 🛠️

# 📚 How to Use

## 🔧 Function Tags
The library provides several function tags that you can use to add your custom recipes:

### 🔨 Smelting, Blasting, Smoking

The function tags are the following:
- `#furnace_nbt_recipes:v1/smelting_recipes`: 🔥 Recipes in a classic furnace
- `#furnace_nbt_recipes:v1/blasting_recipes`: ⚒️ Recipes in a blast furnace (e.g. ores)
- `#furnace_nbt_recipes:v1/smoking_recipes`: 🍖 Recipes in a smoker (e.g. food)

📝 In any of these function tags, you must add a call to a function you created that will handle the recipe.<br>
✅ Each line should check if the `#found` score is 0 and the input matches your recipe.<br>
🔄 If so, it will run a loot table command in the `container.3` slot.

⚡ Taken example from [SimplEnergy](https://github.com/Stoupy51/SimplEnergy/blob/main/build/datapack/data/simplenergy/function/calls/furnace_nbt_recipes/smelting_recipes.mcfunction):

```mcfunction
# Smelt 'Raw Simplunium' into 'Simplunium Ingot'
execute if score #found furnace_nbt_recipes.data matches 0 store result score #found furnace_nbt_recipes.data if data storage furnace_nbt_recipes:main input{"components": {"minecraft:custom_data": {"simplenergy": {"raw_simplunium": true}}}} run loot replace block ~ ~ ~ container.3 loot simplenergy:i/simplunium_ingot
```

### `#furnace_nbt_recipes:v1/disable_cooking`

🔧 As the library stands on fake recipes, we need to prevent the default vanilla items from smelting ⚠️<br>
Therefore, you should use this function tag to disable them with the following syntax ⬇️:

```mcfunction
# For instance, if a custom recipe uses command block as a base item:
execute if score #reset furnace_nbt_recipes.data matches 0 store success score #reset furnace_nbt_recipes.data if data storage furnace_nbt_recipes:main input{"id":"minecraft:command_block"}
```

### `#furnace_nbt_recipes:v1/recipes_used`
⚡ Configure XP rewards for your custom recipes when a player retrieves items from the furnace.<br>
🎯 The XP amount can be customized based on the input item and furnace type (🔥 regular furnace, ⚒️ blast furnace, or 🍖 smoker).<br>
✨ Taken example from [SimplEnergy](https://github.com/Stoupy51/SimplEnergy/blob/main/build/datapack/data/simplenergy/function/calls/furnace_nbt_recipes/recipes_used.mcfunction):

```mcfunction
# Give 0.8 XP for smelting 'Raw Simplunium'
execute if score #found furnace_nbt_recipes.data matches 0 store result score #found furnace_nbt_recipes.data if data storage furnace_nbt_recipes:main input{"components": {"minecraft:custom_data": {"simplenergy": {"raw_simplunium": true}}}} run function simplenergy:calls/furnace_nbt_recipes/xp_reward/0.8
```

## 📝 Recipe Format

📝 For each custom recipe you make, you'll need to add a recipe that take the base item ingredient as ingredient and result the base item of the result.<br>
⚠️ This part is really wanky and I don't want people to use this library so here is a link to [SimplEnergy's example](https://github.com/Stoupy51/SimplEnergy/blob/main/build/datapack/data/furnace_nbt_recipes/recipe/vanilla_items/smelting__command_block__minecraft_diamond.json).

