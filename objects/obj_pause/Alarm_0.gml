/// @description restart (levels are in step)
with all
	if !persistent instance_destroy(id, false);

var timeattack = global.timeattack;
var snickrematch = global.snickrematch;

global.pizzacoin = global.pizzacoinstart;
global.minichat = global.minichatstore

if !fmod_is_instance_playing(global.jukebox)
	fmod_stop_all();
else
	fmod_resume_all();
	
instance_activate_all();
global.music = FMOD_EMPTY;

// fuck you mu_war
instance_destroy(obj_wartimer)
instance_destroy(obj_randomsecret)
global.wartimer = false // eat shit, mu_war

// player reset shit
pause = 0;
scr_playerreset();
with obj_player
{
	targetDoor = "A";
	scr_prankreset(scr_prankreset(string_contains(scr_levelname(), "snick")))
}
global.snickrematch = snickrematch; // stored

// modifier
global.failedmod = false;
if global.modifier != -1
{
	with obj_drpc_updater
		event_user(3);
}


// go to da levels
if gotoroom != -1
	room_goto_new(gotoroom);

// reset time attack
global.timeattack = timeattack;
with obj_music	
	alarm[1] = 1
with obj_timeattack
	newalarm = 60;

// create nice fadeout instead of just a cut into the level
with instance_create(0, 0, obj_fadeout)
{
	fadealpha = 1;
	fadein = true;
	global.chancetogetonthatprank = true
}
