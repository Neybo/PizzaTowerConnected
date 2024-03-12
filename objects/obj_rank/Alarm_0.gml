if global.jukebox != FMOD_EMPTY
	fmod_resume_instance(global.jukebox);

global.pizzacoinstart = global.pizzacoin;

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

