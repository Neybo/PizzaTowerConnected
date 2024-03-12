/// @description savedata and login
if loadsave
{
	global.logged = true;
	if !gms_ini_player_exists("saveData", "lastversion")
	or gms_ini_player_read("saveData", "lastversion") != game_version
		gms_ini_player_write("saveData", "lastversion", game_version);
	// pizzacoin
	scr_setcoin(0);
	if gms_ini_player_exists("saveData", "pizzacoin")
		scr_setcoin(gms_ini_player_read("saveData", "pizzacoin"));
	else
	{
		gms_ini_player_write("saveData", "pizzacoin", 0);
	}
	global.pizzacoinstart = global.pizzacoin;
	
	// hat unlocks
	global.hatunlock = [true];
	for(var i = 0; i < HATS.length; i++)
	{
		if gms_ini_player_exists("hats", i)
			global.hatunlock[i] = true;
	}

	// travel
	fmod_stop_all();

	scr_soundeffect(sfx_collecttoppin);
	with obj_player
	{
		targetDoor = "A";
		targetRoom = hub_room1;
		state = states.door;
	}
	instance_create(x, y, obj_fadeout);
	
	with obj_shell
		WC_debug = gms_self_admin_rights() || debug || !release;
		
	if (window_get_caption() == "Pizza Tower: Connected - " + lang_str("caption.youlivehere")) 
	&& !global.streamer
		window_set_caption("Pizza Tower: Connected - " + lang_str("caption.youlive") + " "
		+ gms_location_countryname() + ".")
	
	with obj_player
	{
		nickcol = c_white

		if (check_online())
		{
			if gms_self_isowner()
				nickcol = c_owner;
			else if gms_self_admin_rights()
				nickcol = c_admin;
			else if global.pvp
				nickcol = c_pvp;
		}
	}
}
else
	alarm[3] = 10;

