instance_activate_all();
room_goto(hub_room1);
if !fmod_is_instance_playing(global.jukebox)
	fmod_stop_all();
alarm[1] = 2;