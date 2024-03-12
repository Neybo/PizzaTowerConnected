function scr_player_firedrill(){
	image_speed = 0.35
	
	if instance_place(x, y - 5, obj_boilingsauce)
	{
		image_blend = c_white
		state = states.firedrill
		sprite_index = spr_firedrillstart
		image_index = 0
	}

	with instance_place(x + hsp, y + vsp, obj_ratblock)
        instance_destroy()
	
	if sprite_index == spr_firedrill || sprite_index == spr_firedrillstart
	{
		move = key_left + key_right;
		if OLD_GAMEPLAY
		{
			if move != 0
				xscale = move
			
			hsp = move * 2
		}
		else
		{
	        hsp = movespeed // clamp that shit
	        if move != 0
	        {
	            if move == xscale
	                movespeed = Approach(movespeed, (xscale * 5), 0.5)
	            else
	                movespeed = Approach(movespeed, 0, 0.5)
	            if movespeed <= 0
	                xscale = move
	        }
	        else
	            movespeed = Approach(movespeed, 0, 0.1)
		}

		if !grounded && (key_slap2 || key_extra2)
		{
			state = states.firedrillattack
			vsp = 0
			sprite_index = spr_firedrillattack
			image_index = 0
			image_speed = 0.55
			exit;
		}

		if grounded && vsp > 0 && !place_meeting(x, y + 1, obj_ratblock)
		{
			instance_create(x, y, obj_landcloud)
			
			movespeed = 3
			sprite_index = spr_fireassground
		}
	}
	
	if floor(image_index) == image_number - 1 && sprite_index == spr_firedrillstart
		sprite_index = spr_firedrill

	if sprite_index = spr_fireassground
	{
		hsp = xscale * movespeed
		if movespeed > 0
			movespeed -= 0.25
	
		if floor(image_index) = image_number-1
		{
			movespeed =0
			landAnim = false
			alarm[5] = 2
			alarm[7] = 60
			hurted = true
			state = states.normal
			sprite_index = spr_idle
			image_index = 0
		}
	}
}