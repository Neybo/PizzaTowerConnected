if fmod_is_instance_playing(global.jukebox)
	sprite_index = dancespr;
else
{
	sprite_index = idlespr;
	with obj_player
	{
		if x != other.x
			other.image_xscale = sign(x - other.x);
	}
}

