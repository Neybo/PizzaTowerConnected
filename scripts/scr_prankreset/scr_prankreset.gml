function scr_prankreset(snickchallenge, lvlname = scr_levelname()){
	global.chancetogetonthatprank = true
	global.lap2 = false
	global.treasure = false
		
	if (lvlname == "molasses")
	{
		global.lapextratime = 115
	}
	else if lvlname == "ruin" || lvlname == "dungeon" || lvlname == "saloon"
	{
		global.lapextratime = 80
	}
	else
		global.lapextratime = 50
		
	with obj_player {		
		secretsneeded = 3
		treasureneeded = true
		lap2needed = true
		toppinsneeded = 3
	
		if (lvlname == "etb")// etb only has 2 secrets 
			secretsneeded = 2
		if snickchallenge || lvlname == "golf" || lvlname == "grinch"
		{ 
			secretsneeded = 0
			treasureneeded = false
			if snickchallenge
				|| lvlname == "grinch" || (lvlname == "golf" && OLD_GAMEPLAY)
				lap2needed = false
			if snickchallenge
				|| lvlname == "golf" 
				toppinsneeded = 0
		}
		if lvlname == "dragonlair"
		{
			lap2needed = false
			toppinsneeded = 0
			treasureneeded = false	
		}
		if lvlname == "exit" || lvlname == "secrets"
		{
			if lvlname == "secrets"
				lap2needed = false
			treasureneeded = false
			toppinsneeded = 0
			secretsneeded = 0
		}
	}
}