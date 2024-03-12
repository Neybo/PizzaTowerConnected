function scr_secretsoutof(level = global.leveltosave){
	if level == "none"
		return 0;
	var outof = 6;
	if level == "etb"
		outof = 2;
	if level == "mansion"
	or level == "sewer"
	or level == "dragonlair"
	or level == "factory"
	or level == "freezer"
	or level == "d2factory"
	or level == "saloon"
	or level == "war"
	or level == "finalforest"
	or level == "finaldungeon"
	or level == "finalruin"
	or level == "finalentrance"
		outof = 3;
	return outof
}