function scr_player_rocketslide()
{
	hsp = xscale * movespeed;
	movespeed = Approach(movespeed, 0, 0.5);
	vsp = 0;
	if (steppybuffer > 0)
		steppybuffer--;
	else
	{
		instance_create(x, y + random_range(10, 20), obj_cloudeffect);
		steppybuffer = 8;
	}
	if (movespeed <= 0)
	{
		state = states.rocket;
		sprite_index = spr_rocket;
		image_index = 0;
		movespeed = 12;
		xscale *= -1;
	}
}
