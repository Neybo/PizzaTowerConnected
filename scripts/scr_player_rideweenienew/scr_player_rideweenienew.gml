function scr_player_rideweenienew()
{
	hsp = movespeed;
	move = key_right + key_left;
	if (sprite_index != spr_turnweenie)
		sprite_index = spr_rideweenie;
	if (move != 0)
	{
		if (move == xscale)
			movespeed = Approach(movespeed, xscale * 16, 0.35);
		else
		{
			movespeed = Approach(movespeed, 0, 0.7);
			if (abs(movespeed) <= 0)
			{
				xscale = move;
				sprite_index = spr_turnweenie;
				image_index = 0;
				
			}
		}
		if (abs(movespeed) < 3 && move != 0)
			image_speed = 0.35;
		else if (abs(movespeed) > 3 && abs(movespeed) < 6)
			image_speed = 0.45;
		else
			image_speed = 0.6;
	}
	else
		movespeed = Approach(movespeed, 0, 0.7);
	if (sprite_index == spr_turnweenie && animEnd)
		sprite_index = spr_rideweenie;
	
	if (place_meeting(x + hsp, y, obj_solid) && !place_meeting(x + hsp, y, obj_slope) 
	&& !place_meeting(x + hsp, y, obj_ratblock) && !place_meeting(x + hsp, y, obj_destructibles))
	{
		if (abs(hsp) < 3)
			hsp = 0;
		else
		{
			scr_soundeffect(sfx_weeniebump)
			movespeed = -movespeed * 0.5;
			repeat (3)
			{
				with (instance_create(x, y, obj_slapstar))
				{
					hsp = random_range(-5, 5);
					vsp = random_range(-10, 10);
				}
			}
		}
		vsp = -3 * grounded
	}
	else
	{
		if place_meeting(x + sign(hsp), y, obj_ratblock)
		{
			x += 2 * sign(xscale)
		}
	}
	if (key_jump)
	{
		movespeed = abs(hsp);
		if (movespeed < 8)
			movespeed = 8;
		dir = xscale;
		state = states.mach2;
		sprite_index = spr_mach2jump;
		jumpstop = false;
		vsp = -11;
		instance_create(x, y, obj_jumpdust);
		with (instance_create(x, y, obj_weeniemount))
		{
			buffer = 30;
			depth = -2;
			image_xscale = other.xscale;
		}
	}
	if (sprite_index == spr_turnweenie)
		image_speed = 0.55;
	else if (abs(movespeed) < 10)
		image_speed = 0.35;
	else
		image_speed = abs(movespeed) / 16;
}
