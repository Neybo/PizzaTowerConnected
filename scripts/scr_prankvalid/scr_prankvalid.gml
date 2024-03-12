function scr_prankvalid(){

	with obj_player
	{
		/*show_debug_message(string(global.chancetogetonthatprank) + " - "
		+ string(global.combodropped) + " - " + string(global.combo) + " - " + 
		string(lap2needed) + ", " + string(global.lap2) + " - " + string(treasureneeded)
		+ ", " + string(global.treasure) + " - " + string(global.secretfound) + ", "
		+ string(secretsneeded) + " - " + string(global.toppintotal) + ", " + string(toppinsneeded))*/
		
		return (global.chancetogetonthatprank 
		&& !global.combodropped 
		&& global.combo > 0 
		&& (!lap2needed || global.lap2) 
		&& (!treasureneeded || global.treasure)
		&& global.secretfound >= secretsneeded  
		&& (global.toppintotal - 1) >= toppinsneeded)
	}
	
}