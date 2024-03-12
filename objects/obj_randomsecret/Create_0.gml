if !fullgame || instance_number(obj_randomsecret) > 1
{
	instance_destroy()
	return;
}

// needs to be like this due to inconsistancies with how secrets are done
levels = [
	// entrance (mostly c's wtf?)
	[entrance_secret1, "C"], [entrance_secret2, "C"], [entrance_secret3, "C"], 
	[entrance_secret4, "C"], [entrance_secret5, "E"], [entrance_secret6, "S"],

	// final entrance 
	[FINALentrance_secret3, "S"], [FINALentrance_secret4, "S"], [FINALentrance_secret5, "S"],

	// medieval
	[medieval_secret1, "C"], [medieval_secret2, "S"], [medieval_secret3, "A"],
	[medieval_secret4, "C"], [medieval_secret5, "S"], [medieval_secret6, "S"],

	// ruin
	[ruin_secret1, "S"], [ruin_secret2, "S"], [ruin_secret3, "S"],
	[ruin_secret4, "A"], [ruin_secret5, "S"], [ruin_secret6, "S"],
	
	// final ruin
	[FINALruin_secret1, "S"], [FINALruin_secret4, "S"], [FINALruin_secret6, "S"],
	
	// dungeon
	[dungeon_secret1, "S"], [dungeon_secret2, "S"], [dungeon_secret3, "B"],
	[dungeon_secret4, "S"], [dungeon_secret5, "S"], [dungeon_secret6, "S"],
	
	// final dungeon
	[FINALdungeon_secret1, "S"], [FINALdungeon_secret2, "S"], [FINALdungeon_secret3, "S"], 
	
	// desert
	[floor1_secret1, "S"], [floor1_secret2, "D"], [floor1_secret3, "S"], 
	[floor1_secret4, "S"], [floor1_secret5, "S"], [floor1_secret6, "S"], 
	
	// graveyard
	[graveyard_secret1, "D"], [graveyard_secret2, "E"], [graveyard_secret3, "D"], 
	[graveyard_secret4, "A"], [graveyard_secret5, "S"], [graveyard_secret6, "S"], 
	
	// farm
	[farm_secret1, "S"], [farm_secret2, "C"], [farm_secret3, "S"], 
	[farm_secret4, "C"], [farm_secret5, "C"], [farm_secret6, "S"], 
	
	// saloon
	[saloon_secret1, "S"], [saloon_secret2, "S"], [saloon_secret3, "S"],
	
	// beach
	[beach_secret1, "S"], [beach_secret2, "C"], [beach_secret3, "C"],
	[beach_secret4, "C"], [beach_secret5, "S"], [beach_secret6, "C"],
	
	// forest
	[forest_secret1, "C"], [forest_secret2, "C"], [forest_secret3, "C"], 
	[forest_secret4, "C"], [forest_secret5, "C"], [forest_secret6, "S"], 
	
	// final forest
	[FINALforest_secret2, "S"],
	
	// space
	[space_secret1, "C"], [space_secret2, "D"], [space_secret3, "S"], 
	[space_secret4, "S"], [space_secret5, "A"], [space_secret6, "C"], 
	
	// ufo
	[ufo_secret1, "S"], [ufo_secret2, "S"], [ufo_secret3, "S"],  
	[ufo_secret4, "S"], [ufo_secret5, "B"], [ufo_secret6, "S"],  
	
	// chateau
	[chateau_secret1, "C"], [chateau_secret2, "S"], [chateau_secret3, "A"], 
	[chateau_secret4, "C"], [chateau_secret5, "S"], [chateau_secret6, "S"], 
	
	// dragonlair
	[dragonlair_secret1, "S"], [dragonlair_secret2, "S"], [dragonlair_secret3, "S"], 
	
	// d2factory
	[d2factory_secret1, "S"], [d2factory_secret2, "S"], [d2factory_secret3, "S"],
	
	// oldfreezer
	[oldfreezer_secret1, "S"], [oldfreezer_secret2, "H"], [oldfreezer_secret3, "Q"],
	
	// oldmansion
	[oldmansion_secret1, "S"], [oldmansion_secret2, "A"], [oldmansion_secret3, "C"],
	
	// misc
	[ancient_secret3, "S"], 
	
	// WAR
	[war_secret1, "S"], [war_secret2, "S"], [war_secret3, "S"],
	
	/// SUGARY SPIRE
	
	// entryway
	[entryway_secret1, "C"], [entryway_secret2, "C"], [entryway_secret3, "S"], 
	
	// cotton
	[cotton_secret1, "S"], [cotton_secret2, "S"], [cotton_secret3, "C"],
	
	// molasses
	[molasses_secret1, "S"], [molasses_secret2, "D"], [molasses_secret3, "C"]
]

secretsleft = array_length(levels)
depth = -999

with obj_player
{
	secretsneeded = 0
	treasureneeded = false
	lap2needed = false
	toppinsneeded = false
}

seconds = -1