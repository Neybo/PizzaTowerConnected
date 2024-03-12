if song != FMOD_EMPTY
{
	fmod_set_vol(global.music, global.musicvolume, false);
	fmod_release_instance(song);
}

