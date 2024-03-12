if !(debug && keyboard_check(ord("R")))
{
	ini_open("saveData.ini");
	if ini_read_real("online", "mario", false) == true
	{
		instance_destroy(obj_darkroom);
		instance_destroy();
		instance_destroy(obj_arcademachine);
		ini_close();
		exit;
	}
	ini_close();
}

with obj_player
{
	if character != "PP"
	{
		instance_destroy(obj_darkroom);
		instance_destroy(other);
		exit;
	}
}

with obj_darkroom
	image_alpha = 0;

trigger = true;
sounddark = -1
func = function()
{
	with obj_darkroom
		image_alpha = clamp((obj_player.x - 5000) / 1000, 0, 1);
	fmod_set_vol(global.music, global.musicvolume * (1 - obj_darkroom.image_alpha), false);
	if (sounddark == FMOD_EMPTY)
		sounddark = scr_soundeffect_ext(mu_darkroomtheme, true)
	fmod_set_vol(sounddark, global.musicvolume * (obj_darkroom.image_alpha), false);
}
cleanup = function()
{
	fmod_stop_instance_immediately(sounddark)
}
