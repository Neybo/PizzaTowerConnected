function scr_player_dogmount()
{
	hsp = movespeed;
	move = key_right + key_left;
	if (sprite_index != spr_turnweenie && sprite_index != spr_player_machfreefall)
		sprite_index = spr_rideweenie;
	if (move != 0)
	{
		if (move == xscale)
			movespeed = Approach(movespeed, (13 - (9 * sprite_index == spr_turnweenie)) * xscale, 
			3.5 / ((movespeed < 0) * 2));
		else
		{
			movespeed = Approach(movespeed, 0, 0.8);
			if (abs(movespeed) <= 4)
			{
				xscale = move;
				sprite_index = spr_turnweenie;
				image_index = 0;
				
			}
		}
		image_speed = 0.35
	}
	else
		movespeed = Approach(movespeed, 0, 1.2);
		
	if key_slap2 && pizzymidairgrab < 2
	{
		pizzymidairgrab++
		scr_soundeffect(sfx_Nspin)
		movespeed = 13 * xscale
		state = states.dogmountspin
		sprite_index = spr_playerSP_dogmountspin
		image_index = 0
		return
	}

	grav = 0.5 / (1 + sprite_index == spr_player_machfreefall)
		
	if (sprite_index == spr_turnweenie || sprite_index == spr_player_machfreefall) && animEnd
		sprite_index = spr_rideweenie;
	
	//Jump Stop
	if (!key_jump2) && jumpstop = false && vsp < 0.5 
	{
		vsp /= 10
		jumpstop = true
	}

	if grounded && vsp > 0
	{
		jumpstop = false
		pizzymidairgrab = 0
	}
	//Jump
	if key_jump && grounded 
	{
		input_buffer_jump = 8
		scr_soundeffect(sfx_jump)
		instance_create(x,y,obj_highjumpcloud2)
		vsp = -12
	}

	//Input buffer jumping
	if key_jump
		input_buffer_jump = 0

	// bump 
	if (place_meeting(x + hsp, y, obj_solid) && !place_meeting(x + hsp, y, obj_slope) 
	&& !place_meeting(x + hsp, y, obj_destructibles))
	{
		if grounded
		{
			if (abs(hsp) < 3)
				hsp = 0;
			else
			{
				scr_soundeffect(sfx_weeniebump)
				movespeed = -movespeed * 0.85;
				hsp = movespeed;
				repeat (3)
				{
					with (instance_create(x, y, obj_slapstar))
					{
						hsp = random_range(-5, 5);
						vsp = random_range(-10, 10);
					}
				}
			}
			vsp = -3
		}
		else
			hsp = 0
	}

	//Effect
	if !(instance_exists(dashcloudid)) && grounded && move != 0
	with instance_create(x,y,obj_dashcloud)
	{
		image_xscale = other.xscale
		other.dashcloudid = id
	}

	image_speed = 0.5
}