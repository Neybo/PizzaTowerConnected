if !ready
	exit;
	
ogchar = obj_player.character
ready = true

if selected == 1
	with obj_player
	{
		character = "N";
		scr_characterspr();
		if other.ogchar != character
			paletteselect = 0;
	}
else
	with obj_player
	{
		character = "P";
		scr_characterspr();
		if other.ogchar != character
			paletteselect = 1;
	}