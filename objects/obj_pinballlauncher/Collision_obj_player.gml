with other
{
	if (scr_transformationcheck() or state == states.tumble) && state != states.gotoplayer && (state != states.bump or grounded) && state != states.backbreaker
	{
		if state != states.tumble or xscale != sign(other.image_xscale)
		{
			other.image_index = 0
			other.sprite_index = spr_goblinbot_kick
		}
		
		xscale = sign(other.image_xscale)
		state = states.tumble
		movespeed = 14
		sprite_index = spr_tumble
	}
}

