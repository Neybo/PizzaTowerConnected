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
	audio_sound_gain(global.music, global.musicvolume * (1 - obj_darkroom.image_alpha), 1000);
	if (sounddark == -1)
		sounddark = audio_play_sound(mu_darkroomtheme, 0, true)
	audio_sound_gain(sounddark, global.musicvolume * (obj_darkroom.image_alpha), 1000);
}

