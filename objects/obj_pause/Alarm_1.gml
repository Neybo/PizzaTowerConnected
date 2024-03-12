/// @description exit lev
with all
	if !persistent instance_destroy(id, false);

instance_destroy(obj_hallway);
instance_destroy(obj_fadeout);
instance_destroy(obj_wartimer)

global.minichat = global.minichatstore

if global.jukebox == FMOD_EMPTY
	fmod_stop_all();
else
	fmod_resume_all();
	
pause = false;
instance_activate_all();
global.leveltosave = "none"; // dumbass
global.tauntcount = 0
scr_playerreset();
global.hp = 0;

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
		
		// no need for this anymore
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


// create nice fadeout
instance_create(0, 0, obj_fadein);

