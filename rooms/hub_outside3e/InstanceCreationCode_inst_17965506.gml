// fade out music if mach4 pissino is playing
if obj_player.character != "PP"
{
	instance_destroy()
	return;
}

faded = false;
trigger = true; // run every frame

func = function()
{
	if obj_player.movespeed >= 12
	{
		fmod_set_vol(global.music, 0, false);
		faded = true;
	}
	else if faded
	{
		fmod_set_vol(global.music, global.musicvolume, false);
		faded = false;
	}
}
cleanup = function() {
	fmod_set_vol(global.music, global.musicvolume);
}

