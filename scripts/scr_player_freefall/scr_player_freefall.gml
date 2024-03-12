function scr_player_freefall()
{
	visible = true
	landAnim = true
	if global.slopebitch
	{
		if FINAL_GAMEPLAY
		{
			if vsp >= 2
				vsp += 0.5
		}
		else
			vsp = 15
	}
	else
		vsp = max(4, vsp + 0.3)
		
	if floor(image_index) == image_number - 1 && sprite_index == spr_bodyslamstart
        sprite_index = spr_bodyslamfall
	
	move = key_left + key_right;
	if !grounded
	{
		hsp = move * movespeed;
		if sprite_index == spr_rockethitwall
			hsp = 0;
		
		if move != xscale && momentum && movespeed != 0 
			movespeed -= 0.05
		
		if movespeed == 0
			momentum = false

		if (move == 0 && !momentum) or scr_solid(x + hsp, y)
		{
			movespeed = 0
			mach2 = 0
		}
		if move != 0 && movespeed < 7
			movespeed += 0.25
		if movespeed > 7 
			movespeed -= 0.05

		if scr_solid(x + move,y)
			movespeed = 0

		//Turn
		if dir != xscale 
		{
			mach2 = 0
			dir = xscale
			movespeed = 0 
		}
		if move = -xscale
		{
			mach2 = 0
			movespeed = 0 
			momentum = false
		}
		if move != 0
			xscale = move
		
		// cancel out
		if key_attack2 && scr_pizzyphys_check() && freefallsmash > 10
		{
			landAnim = false;
			mach2 = 35;
			momentum = true;
			jumpstop = true;
			dir = xscale;
		
			scr_soundeffect(sfx_suplexdashSP)
			movespeed = 10
			sprite_index = spr_mach2jump
		
			with instance_create(x, y, obj_mach3effect)
			{
				hspeed = 0;
				
				playerid = other.object_index
				image_index = other.image_index - 1
				image_xscale = other.xscale
				sprite_index = other.sprite_index
			}
			with instance_create(x, y, obj_mach3effect)
			{
				hspeed = -10;
				
				playerid = other.object_index
				image_index = other.image_index - 1
				image_xscale = other.xscale
				sprite_index = other.sprite_index
			}
		
			flash = true
			state = states.mach2
			if FINAL_GAMEPLAY
				vsp = -7;
		}
	}
	
	if OLD_GAMEPLAY
	{
		if sprite_index != spr_bodyslamstart
	        freefallsmash++
		freefallsmash++
	}
	else
	{
		if vsp > 0
	        freefallsmash++
	    else if vsp < 0
	        freefallsmash = -14
	}
	
	if freefallsmash >= 11 && !instance_exists(superslameffectid)
	{
		with instance_create(x, y, obj_superslameffect)
		{
			playerid = other.object_index	
			other.superslameffectid = id
		}
	}
	
	//Normal
	if (grounded && ((freefallsmash < 11 or OLD_GAMEPLAY) 
	or (!place_meeting(x, y + 1, obj_destructibles)))
	or (!place_meeting(x, y, obj_platform) && place_meeting(x, y + 1, obj_platform))) 
	&& !place_meeting(x, y, obj_mushroom)
	{
		if scr_slope() && FINAL_GAMEPLAY
        {
            with instance_place(x, y + 1, obj_slope)
            {
                other.xscale = -sign(image_xscale)
                other.state = states.tumble
                other.sprite_index = other.spr_crouchslip
				if FINAL_GAMEPLAY_ONLY
				{
	                if other.freefallsmash > 20
	                    other.movespeed = 12
	                else
	                    other.movespeed = 8
				}
				else
					other.movespeed = other.freefallsmash / 1.5
            }
			with instance_create(other.x, other.y, obj_jumpdust)
                image_xscale = other.xscale
	    }
		else
		{
			fmod_stop_instance_immediately(groundpoundsnd)
			groundpoundsnd = scr_soundeffect(sfx_groundpound)
			freefallsmash = 0
		
			if sprite_index == spr_poundcancel1
                sprite_index = spr_poundcancel2
			else if !shotgunAnim or character == "SP"
				sprite_index = spr_bodyslamland
			else
				sprite_index = spr_shotgunjump2
			
			image_index = 0
			state = states.freefallland
			jumpAnim = true
			jumpstop = false
			
			with obj_camera
            {
                shake_mag = 5
                shake_mag_acc = 15 / room_speed
            }
			if freefallsmash >= 10 or OLD_GAMEPLAY
            {
				with obj_baddie
				{
					if grounded && point_in_camera(x, y, view_camera[0]) && !invincible && groundpound
					{
						state = states.stun
						if stunned < 60
							stunned = 60
						vsp = -11
						image_xscale *= -1
						hsp = 0
						momentum = 0
					}
				}
				with obj_camera
				{
					shake_mag = 10;
					shake_mag_acc = 30 / room_speed;
				}
			
				combo = 0
				bounce = false
			}
			
			if OLD_GAMEPLAY
				instance_create(x, y, obj_landcloud)
			else
			{
				with instance_create(x, y + 3, obj_landcloud)
				{
					sprite_index = spr_groundpoundeffect;
					image_speed = 0.25;
				}
			}
			freefallstart = 0
		}
	}
	image_speed = 0.35
	if sprite_index == spr_bodyslamstart
        image_speed = 0.4
}
