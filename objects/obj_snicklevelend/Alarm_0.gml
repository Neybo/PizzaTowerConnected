
	global.pizzacoinstart = global.pizzacoin;
	if global.timeattack
	{
		ini_open("saveData" + string(global.saveslot) + ".ini");
		scr_savetatime(scr_levelname());
		ini_close();
	}
	
	scr_playerreset();
	if FINAL_GAMEPLAY
	{
		with obj_player
		{
			targetDoor = "NONE";
			if backtohubstartx == 0 && backtohubstarty == 0
				targetDoor = "A";
			else
			{
				x = backtohubstartx;
				y = backtohubstarty;
			}
			room_goto(backtohubroom);
		
			backtohubstartx = 0;
			backtohubstarty = 0;
			backtohubroom = hub_room1;
		}
	}
	else
	{
		with obj_player
			targetDoor = "A";
		room_goto(hub_room1);
	}