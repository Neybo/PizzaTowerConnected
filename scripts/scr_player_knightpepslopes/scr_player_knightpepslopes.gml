function scr_player_knightpepslopes()
{
	alarm[5] = 2
	alarm[7] = 60
	hurted = true
	hsp = xscale * movespeed
	
	if sprite_index == spr_knightpepdownslope
		movespeed = 15
	
	if grounded
	{
		if !scr_slope()
			sprite_index = spr_knightpepcharge
		else
			sprite_index = spr_knightpepdownslope
	}
	
	var rat = instance_place(x + hsp, y, obj_ratblock)
	if rat
		instance_destroy(rat)
	
	if ((key_jump || input_buffer_jump < 8) && FINAL_GAMEPLAY)
	{
		if (grounded || doublejump < 2)
		{
			vsp = -11;
			sprite_index = spr_knightpepfly;
			image_index = 0;
			if doublejump != 2
				doublejump = 1
			if (doublejump == 1 && !grounded)
			{
				repeat (4)
				{
					with (instance_create(x + random_range(-50, 50), 
					y + random_range(0, 50), obj_highjumpcloud2))
					{
						vspeed = 2;
						sprite_index = spr_cloudeffect;
					}
				}
				vsp = -11;
				doublejump = 2;
				sprite_index = spr_knightpepdoublejump;
				image_speed = 0.4
			}
			else if (doublejump < 2)
			{
				with instance_create(x, y, obj_highjumpcloud2)
					image_xscale = other.xscale
			}
			grounded = false
		}
	}
	
	if doublejump == 2
		sprite_index = spr_knightpepdoublejump;
		
	if !grounded && key_down && sprite_index != spr_knightpepdownthrust
	{
		state = states.knightpep
		sprite_index = spr_knightpepdownthrust
		image_index = 0
		hsp = 0
		move = 0
        knightdowncloud = true
        vsp = -5
        movespeed = 0
		scr_soundeffect(sfx_whoosh)
    }
    if (sprite_index == spr_knightpepdownthrust && vsp >= 0)
    {
        if (knightdowncloud && vsp >= 12)
        {
            with (instance_create(x, (y - 16), obj_parryeffect))
                sprite_index = spr_knightpep_downcloud
            knightdowncloud = false
        }
        vsp += 0.5
	}
		
	if (sprite_index != spr_knightpepfly && sprite_index != spr_knightpepdoublejump 
	&& sprite_index != spr_knightpepcharge && !grounded && sprite_index != spr_knightpepdownthrust)
		sprite_index = spr_knightpepfly;
		
	if ((sprite_index == spr_knightpepdoublejump || sprite_index == spr_knightpepfly) 
	&& floor(image_index) == (image_number - 1))
		image_index = image_number - 1;
	
	if grounded
		doublejump = 0
	
	//Bump
	if scr_solid(x + sign(hsp), y) && !place_meeting(x + sign(hsp), y, obj_destructibles)
	&& (!place_meeting(x + sign(hsp), y, obj_slope) or scr_solid_slope(x + sign(hsp), y))
		scr_transfobump();
	
	if movespeed <= 0 && sprite_index == spr_knightpepcharge
		movespeed = 15;
	
	image_speed = 0.9
}

