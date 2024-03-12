if global.jukebox == FMOD_EMPTY	&& !fmod_is_instance_playing(global.music)
{
	with obj_music
		alarm[1] = 1
}