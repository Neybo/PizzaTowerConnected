function scr_player_tumble()
{
	if FINAL_GAMEPLAY
	{
		var railh = 0, railmeet = instance_place(x, y + 1, obj_railparent);
		if railmeet then railh = railmeet.spdh;
	    hsp = xscale * movespeed + railh;
		
	    move = key_right + key_left
	    mask_index = spr_crouchmask
	    if sprite_index == spr_tumblestart
	        movespeed = 6
	    if (!grounded && (sprite_index == spr_machroll or sprite_index == spr_mach2jump 
		or sprite_index == spr_backslide or sprite_index == spr_backslideland or
		sprite_index == spr_crouchslip))
	    {
	        vsp = 10
	        sprite_index = spr_dive
	    }
	    if (grounded && sprite_index == spr_dive)
	    {
	        sprite_index = spr_machroll
	        image_index = 0
	    }
		//	if (grounded)
		//		movespeed -= 0.05
	    if (sprite_index == spr_dive && key_jump)
	    {
	        sprite_index = spr_poundcancel1
	        image_index = 0
	        state = states.freefallprep
	        vsp = -6
	    }
	    if (movespeed <= 2 && sprite_index != spr_breakdance)
	    {
			if (scr_solid(x, y - 16) || scr_solid(x, y - 32))
			{
				sprite_index = spr_machroll
				if (place_meeting(x + xscale, y, obj_solid))
					xscale *= -1
				movespeed = 6
			}
			/*else
				state = states.normal*/
		}
		
	    if (!scr_slope() && sprite_index == spr_tumblestart && floor(image_index) < 11)
	        image_index = 11
		
		if sprite_index == spr_tumble && ((scr_solidwall(x + xscale, y)
		&& !place_meeting(x + hsp, y, obj_destructibles)
		&& !place_meeting(x + hsp, y, obj_rollblock))
		or place_meeting(x, y, obj_timedgate))
		{
			image_index = 0
			scr_soundeffect(sfx_tumble4)
			sprite_index = spr_tumbleend
			state = states.bump;
			hsp = 0
			movespeed = 0
			exit;
		}
		
	    if (sprite_index == spr_mach2jump && grounded)
	    {
	        image_index = 0
	        sprite_index = spr_machroll
	    }
	   /* if (sprite_index == spr_crouchslip && (!grounded))
	        sprite_index = spr_player_jumpdive2
	    
	    if (sprite_index == spr_player_jumpdive2 && grounded)
	        sprite_index = spr_crouchslip*/
		 if (sprite_index == spr_machroll && (!grounded))
	        sprite_index = spr_mach2jump
		 if (sprite_index == spr_superjumpcancel && grounded)
	        sprite_index = spr_crouchslip
		if floor(image_index) >= image_number - 1
		{			
			 if (sprite_index == spr_backslideland || sprite_index == spr_playerV_divekickstart)
		        sprite_index = spr_backslide 
				
			if (sprite_index == spr_machroll && movespeed > 12)
		    {
		        sprite_index = spr_backslide
		        image_index = 0
		    }
				
			if (sprite_index == spr_tumblestart)
			{
				sprite_index = spr_tumble
				movespeed = 14
			}
		}
		
	    if key_jump
	        input_buffer_jump = 0
	    if (!key_jump2 && !jumpstop && vsp < 0.5)
	    {
	        vsp /= 2
	        jumpstop = true
	    }
	    if (grounded && vsp > 0 && (!(place_meeting(x, y, obj_bigcheese))))
	        jumpstop = false
			
	    if (input_buffer_jump < 8 && grounded && hsp != 0 && sprite_index == spr_tumble)
	    {
	        with (instance_create(x, y, obj_highjumpcloud2))
	            image_xscale = other.xscale
	        vsp = -11
	        image_index = 0
	    }
		
	    if (crouchslipbuffer > 0)
	        crouchslipbuffer--
			
		var headhit = (!(scr_solid(x, (y - 16)))) && (!(scr_solid(x, (y - 32)))) 
		var bumpcheck = sprite_index != spr_breakdance && sprite_index != spr_tumble 
		 if (place_meeting(x + xscale, y, obj_solid) or scr_solid_slope(x + xscale, y)) 
		&& !place_meeting(x + hsp, y, obj_rollblock) 
		&& !place_meeting(x + hsp, y, obj_rattumble)
		&& (!place_meeting(x + hsp, y, obj_destructibles) or place_meeting(x, y, obj_timedgate))
	    {
			if OLD_GAMEPLAY
			{
		        scr_soundeffect(sfx_bumpwall)
				grav = basegrav
				movespeed = 0
				state = states.bump
				hsp = 2.5 * -xscale
				vsp = -3
				mach2 = 0
				image_index = 0
				machslideAnim = true
				machhitAnim = false
				instance_create(x + 10 * xscale, y + 10, obj_bumpeffect)
			}
			else if sprite_index != spr_dive || (global.gameplay == 2) // fix yyc warn?
			{
				hsp = 0
				movespeed = 0
				state = states.normal
				exit;
			}
		}
		if (!key_down && key_attack && (grounded || scr_pizzyphys_check()) && headhit
		&& bumpcheck)
	    {
	        if (crouchslipbuffer == 0)
	        {
	            with (instance_create(x, y, obj_jumpdust))
	                image_xscale = other.xscale
				if sprite_index == spr_crouchslip && FINAL_GAMEPLAY
					movespeed = 14
	            if (movespeed >= 12)
	                state = states.mach3
	            else
	                state = states.mach2
	            image_index = 0
	            sprite_index = spr_rollgetup
	        }
	    }
		if REMIX_GAMEPLAY && key_jump && grounded && bumpcheck
		&& headhit
		{
			scr_soundeffect(sfx_jump)
			input_buffer_jump = 8
			vsp = -11
			state = states.mach2
			movespeed = spd_slide / 1.05
			sprite_index = spr_mach2jump

			with instance_create(x, y, obj_highjumpcloud2)
				image_xscale = other.xscale
		}
	    if ((!key_down) && (!key_attack) && grounded && sprite_index != spr_tumble 
		&& headhit
		&& sprite_index != spr_breakdance)
	    {
	        if (crouchslipbuffer == 0)
	        {
	            if (movespeed > 6)
	            {
	                state = states.machslide
	                sprite_index = spr_machslidestart
	                image_index = 0
	            }
	            else
	                state = states.normal
	        }
	    }
		if sprite_index == spr_dive && scr_solid(x + hsp, y)
		{
			if OLD_GAMEPLAY
			{
				movespeed = 0
				state = states.normal
			}
			else if NOT_REMIX_GAMEPLAY
			{
				scr_soundeffect(sfx_splat)
				state = states.bump
                image_index = 0
                if spr_splat != spr_player_wallsplat || character == "P"
					sprite_index = spr_splat
				else
					sprite_index = spr_bump
			}
		}
		
	    if (sprite_index == spr_crouchslip or sprite_index == spr_breakdancesuper 
		or sprite_index == spr_machroll or sprite_index == spr_tumble 
		or sprite_index == spr_tumblestart or sprite_index == spr_mach2jump)
	        image_speed = (abs(movespeed) / 15)
	    else if floor(image_index) == (image_number - 1) 
		&& (sprite_index == spr_mach2jump or sprite_index == spr_crouchslip)
	        image_speed = 0
	    else
	        image_speed = 0.35
		
	    if !instance_exists(dashcloudid) && grounded
	    {
	        with instance_create(x, y, obj_dashcloud)
	        {
	            image_xscale = other.xscale
	            other.dashcloudid = id
	        }
	    }
	}
	else
	{
		if !(sprite_index = spr_tumble || sprite_index = spr_tumblestart)
			movespeed -= 0.05
		
		if sprite_index = spr_crouchslide || sprite_index == spr_crouchslip
			movespeed -= 0.1
		if movespeed < 0
			state = states.normal
		
		hsp = xscale * movespeed
		mask_index = spr_crouchmask

		if sprite_index == spr_tumblestart
			movespeed = 6
	
		if !scr_slope() && sprite_index = spr_tumblestart && floor(image_index) < 11
			image_index = 11
	
		if sprite_index == spr_tumblestart && floor(image_index) >= image_number - 1
		{
			sprite_index = spr_tumble
			movespeed = 14
		}
	
		// bump
		if !grounded && !place_meeting(x + hsp, y, obj_car)
			ledge_bump();
	
		if (scr_solidwall(x + xscale, y)
		&& !place_meeting(x + hsp, y, obj_destructibles)
		&& !place_meeting(x + hsp, y, obj_rollblock))
		or place_meeting(x, y, obj_timedgate)
		{
			if sprite_index != spr_tumbleend
			{
				image_index = 0
				scr_soundeffect(sfx_tumble4)
				sprite_index = spr_tumbleend
			}
			state = states.bump;
			hsp = 0
			movespeed = 0
		}

		//Input buffer jumping
		if key_jump
			input_buffer_jump = 0

		//Jump Stop
		if !key_jump2 && !jumpstop && vsp < 0.5
		{
			vsp /= 2
			jumpstop = true
		}

		if grounded && vsp > 0
			jumpstop = false
	
		//Jump
		if input_buffer_jump < 8 && grounded && hsp != 0 && !key_down && !scr_solid(x, y - 32)
		{
			if REMIX_GAMEPLAY
				scr_soundeffect(sfx_jump)
			input_buffer_jump = 8
		
			vsp = -9
			if FINAL_GAMEPLAY
				vsp = -11
		
			with instance_create(x, y, obj_highjumpcloud2)
				image_xscale = other.xscale
		}
		image_speed = 0.35
	
		//Effect
		if !instance_exists(dashcloudid) && grounded
		{
			with instance_create(x, y, obj_dashcloud)
			{
				image_xscale = other.xscale
				other.dashcloudid = id
			}
		}
	}
}