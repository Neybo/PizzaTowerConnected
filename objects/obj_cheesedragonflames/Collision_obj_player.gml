with other{
	
	if character == "V"
		scr_hurtplayer(id);
	else
	{
		var b = 1

		for (i = 0; i <  array_length(transformation)-1; i+=1)
			if state = transformation[i]
				b = 0

		if b
		{
			state = states.fireass
			image_index = 0
			vsp = -25
			sprite_index = spr_fireass
			fmod_play_instance(snd_fireass)
		}
	}
}