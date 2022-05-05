
##Should be called by function tag #furnace_nbt_recipes:v1/durability_changed
##Set the furnace nbt recipes compared to vanilla durability
##Keep in mind that your multiplier should be >= 1000, or else there is no effect.
##E.g. if you want to multiply durability by a x4.5 factor
##You'll need to put #multiplier score to 4500 (4500 divided by 1000 = 4.5)



#Example taken from SimplEnergy data pack
#Custom durability for Simplunium Armor & Tools (x7 leather armor & x1.2 diamond tools)
#Offhand durability here is useless because no diamond tools can be used in offhand
	scoreboard players set #multiplier furnace_nbt_recipes.data 7000
	execute if score #head_valid furnace_nbt_recipes.data matches 1 if data storage furnace_nbt_recipes:main head{tag:{furnace_nbt_recipes:{simplunium:1b}}} run function furnace_nbt_recipes:v1.0/technical/head
	execute if score #chest_valid furnace_nbt_recipes.data matches 1 if data storage furnace_nbt_recipes:main chest{tag:{furnace_nbt_recipes:{simplunium:1b}}} run function furnace_nbt_recipes:v1.0/technical/chest
	execute if score #legs_valid furnace_nbt_recipes.data matches 1 if data storage furnace_nbt_recipes:main legs{tag:{furnace_nbt_recipes:{simplunium:1b}}} run function furnace_nbt_recipes:v1.0/technical/legs
	execute if score #feet_valid furnace_nbt_recipes.data matches 1 if data storage furnace_nbt_recipes:main feet{tag:{furnace_nbt_recipes:{simplunium:1b}}} run function furnace_nbt_recipes:v1.0/technical/feet
	scoreboard players set #multiplier furnace_nbt_recipes.data 1200
	execute if score #mainhand_valid furnace_nbt_recipes.data matches 1 if data storage furnace_nbt_recipes:main mainhand{tag:{furnace_nbt_recipes:{simplunium:1b}}} run function furnace_nbt_recipes:v1.0/technical/mainhand
	#execute if score #offhand_valid furnace_nbt_recipes.data matches 1 if data storage furnace_nbt_recipes:main offhand{tag:{furnace_nbt_recipes:{simplunium:1b}}} run function furnace_nbt_recipes:v1.0/technical/offhand


#Example that multiply every elytra durability on the server by 2
	scoreboard players set #multiplier furnace_nbt_recipes.data 2000
	execute if score #chest_valid furnace_nbt_recipes.data matches 1 if data storage furnace_nbt_recipes:main chest{id:"minecraft:elytra"} run function furnace_nbt_recipes:v1.0/technical/chest
	##If a multiplier has been applied on a slot, you can't run it again on the same slot so this command will never run.
	execute if score #chest_valid furnace_nbt_recipes.data matches 1 if data storage furnace_nbt_recipes:main chest{id:"minecraft:elytra",tag:{custom_elytra:1b}} run function furnace_nbt_recipes:v1.0/technical/chest


#Example with some fishing rod and shield (x3.14) and different syntaxes
	scoreboard players set #multiplier furnace_nbt_recipes.data 3140
	execute if score #mainhand_valid furnace_nbt_recipes.data matches 1 if data storage furnace_nbt_recipes:main mainhand{tag:{ctc:{id:"diamond_fishing_rod",from:"a_certain_pack"}}} run function furnace_nbt_recipes:v1.0/technical/mainhand
	execute if score #offhand_valid furnace_nbt_recipes.data matches 1 if data storage furnace_nbt_recipes:main offhand.tag.ctc{id:"diamond_fishing_rod",from:"a_certain_pack"} run function furnace_nbt_recipes:v1.0/technical/mainhand
	execute if score #mainhand_valid furnace_nbt_recipes.data matches 1 if data storage furnace_nbt_recipes:main mainhand.tag.some_private_nbt.diamond_shield run function furnace_nbt_recipes:v1.0/technical/mainhand
	execute if score #offhand_valid furnace_nbt_recipes.data matches 1 if data storage furnace_nbt_recipes:main offhand.tag.some_private_nbt{diamond_shield:1b} run function furnace_nbt_recipes:v1.0/technical/mainhand


#Example for every item having lore "Almost Unbreakable" with different syntaxes
	scoreboard players set #multiplier furnace_nbt_recipes.data 2147483647
	execute if score #head_valid furnace_nbt_recipes.data matches 1 if data storage furnace_nbt_recipes:main head.tag.display{Lore:['[{"text":"Almost Unbreakable","italic":false,"color":"red"}]']} run function furnace_nbt_recipes:v1.0/technical/head
	execute if score #chest_valid furnace_nbt_recipes.data matches 1 if data storage furnace_nbt_recipes:main chest.tag{display:{Lore:['[{"text":"Almost Unbreakable","italic":false,"color":"red"}]']}} run function furnace_nbt_recipes:v1.0/technical/chest
	execute if score #legs_valid furnace_nbt_recipes.data matches 1 if data storage furnace_nbt_recipes:main legs{tag:{display:{Lore:['[{"text":"Almost Unbreakable","italic":false,"color":"red"}]']}}} run function furnace_nbt_recipes:v1.0/technical/legs
	execute if score #feet_valid furnace_nbt_recipes.data matches 1 if data storage furnace_nbt_recipes:main feet{tag:{display:{Lore:['[{"text":"Almost Unbreakable","italic":false,"color":"red"}]']}}} run function furnace_nbt_recipes:v1.0/technical/feet
	execute if score #mainhand_valid furnace_nbt_recipes.data matches 1 if data storage furnace_nbt_recipes:main mainhand{tag:{display:{Lore:['[{"text":"Almost Unbreakable","italic":false,"color":"red"}]']}}} run function furnace_nbt_recipes:v1.0/technical/mainhand
	execute if score #offhand_valid furnace_nbt_recipes.data matches 1 if data storage furnace_nbt_recipes:main offhand{tag:{display:{Lore:['[{"text":"Almost Unbreakable","italic":false,"color":"red"}]']}}} run function furnace_nbt_recipes:v1.0/technical/mainhand



