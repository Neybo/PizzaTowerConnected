if global.panic or (global.miniboss && global.minutes <= 0 && global.seconds < 33) or global.snickchallenge
{
	image_speed = 0.5
	if sugary
	{
		sprite_index = spr_siren_active_ss
		image_speed = 0.35
	}
}
else
{
	image_speed = 0
	image_index = 0
	
	if sugary
		sprite_index = spr_siren_idle_ss
}

