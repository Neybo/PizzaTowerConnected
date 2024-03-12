function scr_player_cotton()
{
	image_speed = 0.35;
	
	var drilling = sprite_index == spr_cotton_drill;
	var rolling = sprite_index == spr_cotton_roll or sprite_index == spr_cotton_rollmax;
	
	// break rat blocks
	if drilling or rolling or sprite_index == spr_cotton_attack or movespeed > 6
	{
		with instance_place(x + hsp + xscale, y + vsp, obj_ratblock)
	        instance_destroy()
	}
	
	// move
	if sprite_index != spr_cotton_slam
		move = key_left + key_right;
	
	if !rolling && grounded
		momentum = false;
	
	if move != 0 && !rolling
	{
		if dir != xscale
		{
			dir = xscale;
			movespeed = 0;
		}
		xscale = move;
	}
	
	if drilling
		hsp = move * 2;
	else
	{
		if move != 0 && !rolling
		{
			var maxspeed = 6;
			var acc = 0.5;
			if key_attack && grounded
			{
				maxspeed = 8;
				acc = 0.25;
			}
			if movespeed < 1
				movespeed = 1;
			if movespeed < maxspeed or grounded
				movespeed = Approach(movespeed, maxspeed, acc);
		}
		else if !momentum
			movespeed = 0;
		hsp = xscale * movespeed;
	}
	
	if scr_solid(x + xscale, y) && (!place_meeting(x + xscale, y, obj_slope) or scr_solid_slope(x + xscale, y) or scr_solidwall(x, y - 2))
	&& (!place_meeting(x + xscale, y, obj_destructibles) or movespeed <= 6)
		movespeed = 0;
	
	if vsp > 5 && !drilling
		vsp = 5;
	
	// roll
	if grounded && move != 0 && key_down2
	{
		sprite_index = spr_cotton_roll;
		rolling = true;
		momentum = true;
		
		if movespeed < 3
			movespeed = 3;
	}
	if rolling
	{
		mask_index = spr_crouchmask;
		
		var slop = instance_place(x, y + 2, obj_slope);
		if slop
		{
			if xscale != -sign(slop.image_xscale)
			{
				movespeed -= 0.25;
				if movespeed < 2
				{
					xscale = -sign(slop.image_xscale);
					movespeed = 2;
				}
			}
			else if movespeed < 24
				movespeed += 0.1;
		}
		else if scr_solid(x + xscale, y)
		{
			instance_create(x, y, obj_bangeffect);
			xscale *= -1;
			movespeed = 4;
		}
		dir = xscale;
		
		if movespeed > 8
			sprite_index = spr_cotton_rollmax;
		else if !key_down && !scr_solid(x, y - 16)
		{
			sprite_index = spr_cotton_idle;
			rolling = false;
		}
	}
	
	// jump
	if key_jump && grounded && !drilling
	{
		vsp = -14;
		image_index = 0
		sprite_index = spr_cotton_jump
		instance_create(x, y, obj_highjumpcloud2)
		scr_soundeffect(sfx_cottonjump)
	}
	else if !grounded && !doublejump && key_jump
	{
		doublejump = true
		jumpstop = false
		vsp = -10
		image_index = 0
		sprite_index = spr_cotton_doublejump
		with instance_create(x, y, obj_highjumpcloud2)
			sprite_index = spr_cottonpoof;
		scr_soundeffect(sfx_cottondoublejump)
	}
	
	// attack
	if key_slap2 && sprite_index != spr_cotton_attack && !suplexmove
	{
		suplexmove = true
		jumpstop = true
		flash = true
		image_index = 0
		sprite_index = spr_cotton_attack
		if OLD_GAMEPLAY or !grounded
		{
			vsp = -4
			grounded = false
		}
		scr_soundeffect(sfx_cottonattack)
	}
	
	//Jump Stop
	if !key_jump2 && !jumpstop && vsp < 0.5
	{
		vsp /= 2;
		jumpstop = true;
	}
	if grounded
		jumpstop = false;
	
	// attack
	if sprite_index == spr_cotton_attack
	{
		if movespeed < 8
			movespeed = 8
		hsp = movespeed * xscale
		move = xscale
		
		if grounded && vsp > 0 && OLD_GAMEPLAY
		{
			scr_soundeffect(_sfx_step);
			instance_create(x, y, obj_landcloud);
			
			image_index = 0
			if move == 0
				sprite_index = spr_cotton_land;
			else
				sprite_index = spr_cotton_walk;
		}
		if image_index >= image_number - 1 && FINAL_GAMEPLAY
			sprite_index = spr_cotton_idle;
	}
	
	// animation
	if sprite_index == spr_cotton_idle && move != 0
	{
		image_index = 0
		sprite_index = spr_cotton_walk
	}
	if sprite_index == spr_cotton_walk
	{
		image_speed = max(0.35 * movespeed / 3.5, 0.35);
		if move == 0
		{
			image_index = 0
			sprite_index = spr_cotton_idle
		}
	}
	
	if floor(image_index) >= image_number - 1
	{
		if sprite_index == spr_cotton_jump
		{
			image_index = 0;
			sprite_index = spr_cotton_fall;
		}
		if sprite_index == spr_cotton_doublejump
		{
			image_index = 0;
			sprite_index = spr_cotton_doublefall;
		}
		if sprite_index == spr_cotton_slam
		{
			image_index = 0;
			sprite_index = spr_cotton_idle;
		}
		if sprite_index == spr_cotton_land
		{
			image_index = 0;
			sprite_index = spr_cotton_idle;
		}
		if sprite_index == spr_cotton_land2
		{
			image_index = 0;
			sprite_index = spr_cotton_walk;
		}
	}
	
	// land
	if (sprite_index == spr_cotton_fall or sprite_index == spr_cotton_doublefall or sprite_index == spr_cotton_jump or sprite_index == spr_cotton_doublejump) && (grounded && vsp >= 0)
	{
		image_index = 0
		sprite_index = spr_cotton_land
		instance_create(x, y, obj_landcloud)
		scr_soundeffect(_sfx_step)
	}
	
	if sprite_index == spr_cotton_land && move != 0
		sprite_index = spr_cotton_land2;
	if sprite_index == spr_cotton_land2 && move == 0
		sprite_index = spr_cotton_land;
	
	// drill move
	if key_down2 && !grounded && !drilling && sprite_index != spr_cotton_slam
	{
		vsp = 9
		sprite_index = spr_cotton_drill
		image_index = 0
		scr_soundeffect(sfx_suplexdashSP)
		flash = true
		
		with instance_create(x, y, obj_mach3effect)
		{
			hspeed = -7;
			playerid = other.object_index;
		}
		with instance_create(x, y, obj_mach3effect)
		{
			hspeed = 7;
			playerid = other.object_index;
		}
		with instance_create(x, y, obj_mach3effect)
		{
			vspeed = -7;
			playerid = other.object_index;
		}
		with instance_create(x, y, obj_mach3effect)
		{
			vspeed = 7;
			playerid = other.object_index;
		}
		
		with obj_mach3effect
		{
			if playerid == other.object_index
			{
				image_index = other.image_index - 1;
				image_xscale = other.xscale;
				sprite_index = other.sprite_index;
				keep = true;
			}
		}
	}
	
	if drilling && vsp > 1
		freefallvsp = vsp;
	
	// fall off
	if !grounded && sprite_index != spr_cotton_jump && sprite_index != spr_cotton_attack && sprite_index != spr_cotton_doublejump && sprite_index != spr_cotton_doublefall && sprite_index != spr_cotton_drill && sprite_index != spr_cotton_slam
		sprite_index = spr_cotton_fall
	
	if sprite_index == spr_cotton_slam
	{
		movespeed = 0
		hsp = 0
		move = 0
		dir = 0
	}
	
	// land while drilling
	if drilling && grounded && !place_meeting(x, y + 1, obj_ratblock) && !place_meeting(x, y + 1, obj_destructibles)
	{
		var slop = instance_place(x, y + 2, obj_slope);
		if !slop
		{
			instance_create(x, y, obj_landcloud)
			scr_soundeffect(_sfx_step)
		
			sprite_index = spr_cotton_land
			vsp = 0
			movespeed = 0
			image_index = 0
		}
		else
		{
			sprite_index = spr_cotton_roll;
			xscale = -sign(slop.image_xscale);
			movespeed = freefallvsp * 0.5;
			momentum = true;
			rolling = true;
		}
	}
	
	// walking cloud
	if sprite_index == spr_cotton_walk
	{
		var step1 = 10;
		var step2 = 21;
		if floor(image_index) == step1 or floor(image_index) == step2
		{
			if !steppy
			{
				instance_create(x, y + 43, obj_cloudeffect)
				steppy = true
			}
		}
		else
			steppy = false;
	}
}

