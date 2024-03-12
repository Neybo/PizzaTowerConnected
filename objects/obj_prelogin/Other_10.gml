/// @description play music
alarm[0] = -1;

if !playmusic
{
	if global.musicvolume > 0
	{
		fmod_release_instance(global.music);
		if global.musicgame == 1
			scr_sound(mu_characterselect_pc);
		else
			scr_sound(mu_characterselect);
	}
	
	playmusic = true;
}

con = -1;
