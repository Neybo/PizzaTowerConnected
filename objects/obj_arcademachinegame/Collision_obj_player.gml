with other
{
	if key_up && grounded && state == states.normal
	{
		state = states.victory
		sprite_index = spr_entergate
		image_index = 0
	}
	if state == states.victory && sprite_index == spr_entergate
	&& floor(image_index) >= image_number - 1 && !instance_exists(other.game)
	{
		image_speed = 0
		instance_create(0,0,other.game)
	}
}

