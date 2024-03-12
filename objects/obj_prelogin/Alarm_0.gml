/// @description prelogin
fmod_release_instance(global.music);
if global.musicvolume > 0
{
	if global.musicgame == 1
		scr_sound(mu_prelogin_pc);
	else
		scr_sound(mu_prelogin);
}
