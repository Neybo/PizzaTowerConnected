 if fmod_get_instance_name(global.jukebox) != selarray[sel[1]][0]
{
	fmod_release_instance(global.music)
	fmod_stop_all();
	
	global.music = fmod_create_instance(selarray[sel[1]][0]);
	fmod_set_vol(global.music, global.musicvolume);
	fmod_set_loop(global.music, true)
	fmod_set_param_from_instance_immediately(global.music, "in_jukebox", true)
	fmod_play_instance(global.music)
	global.jukebox = global.music;
	playing = true
}
else
{
	fmod_release_instance(global.music)
	global.jukebox = FMOD_EMPTY;
	playing = false
}

