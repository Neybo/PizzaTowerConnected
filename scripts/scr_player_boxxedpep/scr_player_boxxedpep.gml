function scr_player_boxxedpep()
{
	image_speed = 0.35;
	mask_index = spr_crouchmask
	var run = key_attack && FINAL_GAMEPLAY

	//Input buffer jumping
	if key_jump
		input_buffer_jump = 0

	//Jump Stop
	if !key_jump2 && !jumpstop && vsp < 0.5
	{
		vsp /= 10
		jumpstop = true
	}
	
	if grounded && vsp > 0
		jumpstop = false

	//Turn
	if dir != xscale 
	{
		dir = xscale
		if OLD_GAMEPLAY
			movespeed = 2
		else
			movespeed = 0
	}
	
	if sprite_index != spr_boxxed_intro
	{
		move = key_left + key_right;
		
		var railh = 0, railmeet = instance_place(x, y + 1, obj_railparent);
		if railmeet then railh = railmeet.spdh;
		hsp = xscale * movespeed + railh;
	}

	if scr_solid(x + sign(hsp), y) && xscale == xscale && !place_meeting(x + xscale, y, obj_slope)
		movespeed = 0

	//Input jumping
	if (grounded && input_buffer_jump < 8 && vsp >= 0) && !scr_solid(x, y - 32)
	{
		input_buffer_jump = 8
		scr_soundeffect(sfx_jump)
		instance_create(x, y, obj_highjumpcloud2)
		vsp = -11
		sprite_index = spr_boxxed_jump;
		image_index = 0;
	}
	
	if !run or (movespeed < 10 && !grounded)
	{
		var runspeed = 8
		if FINAL_GAMEPLAY
			runspeed = 6
		
		if move != 0
		{
			if movespeed < runspeed
				movespeed += 0.5
			else if floor(movespeed) == runspeed
				movespeed = runspeed
		}
		else
			movespeed = 0
		if movespeed > runspeed
			movespeed -= 0.1
	}
	else
		movespeed = 10
	
	//Land
	if grounded && vsp >= 0 && (sprite_index == spr_boxxed_jump or sprite_index == spr_boxxed_air)
	{
		scr_soundeffect(_sfx_step)
		instance_create(x, y, obj_landcloud)
	}
	
	//Sprites
	if sprite_index == spr_boxxed_intro && floor(image_index) >= image_number - 1
		sprite_index = spr_boxxed_idle

	if sprite_index != spr_boxxed_intro
	{
		if move != 0 && !run
			xscale = move

		if grounded && vsp >= 0 
		{
			if move != 0 or run
				sprite_index = spr_boxxed_walk
			else
				sprite_index = spr_boxxed_idle
		}
		else if sprite_index != spr_boxxed_jump or floor(image_index) >= image_number - 1
			sprite_index = spr_boxxed_air
	}
	
	//Effects
	if move != 0 && (floor(image_index) == 3 or floor(image_index) == 8) && grounded
	{
		if !steppy
		{
			steppy = true
			instance_create(x, y + 43, obj_cloudeffect)
		}
	}
	else
		steppy = false
}
