if other.key_up2 && other.state == states.normal && !instance_exists(obj_choicebase)
{
	if global.musicvolume > 0
	{
		other.key_up2 = false;
		instance_create(0, 0, obj_songchoice);
	}
	else
		scr_soundeffect(sfx_denied);
}

