/// @description snick challenge restart
var old_snickrematch = global.snickrematch
scr_playerreset()

global.collect = 10000
global.minichat = global.minichatstore

if old_snickrematch
{
	instance_destroy(obj_snickexe);
	instance_destroy(obj_snickexf);
	instance_destroy(obj_snickexg);
	instance_destroy(obj_snickexh);
	
	global.seconds = 49
	global.minutes = 7
	global.snickrematch = true
}
else
{
	global.seconds = 59
	global.minutes = 9
}

global.wave = 0
global.maxwave = (global.minutes * 60 + global.seconds) * 60

obj_player.state = states.comingoutdoor

obj_player.targetDoor = "A"
global.snickchallenge = true
pause = 0

with obj_camera
	alarm[1] = 60;

if !fmod_is_instance_playing(global.jukebox)
	fmod_stop_all();
else
	fmod_resume_all();

global.music = FMOD_EMPTY;

room_goto(medieval_1);

