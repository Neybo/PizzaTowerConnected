hud_posY = 0;

if (room != hub_shop)
{
	instance_destroy()
	exit;
}

function refresh()
{
	global.pigtotal = 0;
	levels = ["entrance", "medieval", "ruin", "dungeon", "desert", "graveyard", "ufo",
			  "kungfu", "forest", "beach", "space", "strongcold", "dragonlair", "farm",
			  "war", "entryway", "cotton", "molasses", "freezer", "sewer", "factory",
			  "golf", "mansion", "snickchallenge", "snickrematch", "medieval_re", 
			  "ruin_re", "dungeon_re", "etb", "d2factory", "ancient", "grinch",
			  "chateau"]

	ini_open("saveData" + string(global.saveslot) + ".ini")
	for (var i = 0; i < array_length(levels); i++)
	{
		global.pigtotal += ini_read_real("Highscore", levels[i], 0)	
	}
	global.pigtotal -= ini_read_real("UnlocksNEW", "spentmoney", 0)
	ini_close()
}
refresh()