global.snickchallenge = false;
global.snickrematch = false;

global.pizzacoin = global.pizzacoinstart;

if !fmod_is_instance_playing(global.jukebox)
	fmod_stop_all();
scr_soundeffect(sfx_pephurt);
scr_soundeffect(sfx_rematchepicfail);
alarm[0] = room_speed * 6;

depth = -50000;