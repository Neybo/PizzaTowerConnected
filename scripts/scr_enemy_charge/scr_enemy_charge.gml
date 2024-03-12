function scr_enemy_charge()
{
	if object_index == obj_peasanto
	{
		if FINAL_GAMEPLAY
		{
			if grounded
				hsp = image_xscale * 6
			else
				hsp = 0
			
			if scr_solid(x + image_xscale, y) or place_meeting(x + hsp, y, obj_hallway)
			{
				if !place_meeting(x + sign(hsp), y, obj_slope)
					image_xscale *= -1
			}
			if !(scr_solid(x + image_xscale * 15, y + 31) or place_meeting(x + image_xscale * 15, y + 31, obj_platform))
				image_xscale *= -1
			
			if !grounded && hsp < 0
				hsp += 0.1
			else if !grounded && hsp > 0
				hsp -= 0.1
			
			sprite_index = spr_peasanto_flameattack
			image_speed = 0.35
		}
		else
		{
			if grounded
				hsp = image_xscale * (movespeed + (global.baddiespeed - 1));
			else
				hsp = 0;
			
			if place_meeting(x + hsp, y, obj_hallway)
			or (scr_solid(x + image_xscale, y) && !place_meeting(x + image_xscale, y, obj_slope))
				image_xscale *= -1;
			
			if hsp != 0
			{
				if !scr_solid(x + hsp * 5, y + 30) && !scr_solid(x + hsp * 5, y + 1)
				&& !place_meeting(x + hsp, y + 30, obj_slope)
					image_xscale *= -1;
			}
			sprite_index = spr_peasanto_attack;
			image_speed = 0.35;
		}
	}
	
	else if object_index == obj_indiancheese
	{
		if floor(image_index) >= image_number - 1
			image_speed = 0;
		
		hsp = image_xscale * movespeed
		if grounded && vsp > 0
		{
			if place_meeting(x + hsp * 2, y, obj_hallway)
			or (scr_solid(x + image_xscale, y) && !place_meeting(x + image_xscale, y, obj_slope))	
				image_xscale *= -1;
			
			state = states.walk;
			image_index = 0;
			image_speed = 0.35;
			sprite_index = spr_indiancheese_land;
		}
	}
	
	//Pizzice
	else if object_index == obj_pizzice
	{
		hsp = image_xscale * (movespeed + (global.baddiespeed - 1))
		image_speed = 0.35
		
		if place_meeting(x + hsp * 2, y, obj_hallway)
		or (scr_solid(x + image_xscale, y) && !place_meeting(x + image_xscale, y, obj_slope))
			image_xscale *= -1;
		
		sprite_index = walkspr
	}
	
	//Fencer
	else if object_index == obj_fencer or object_index == obj_banditochicken
	{
		if grounded
			hsp = image_xscale * (movespeed + (global.baddiespeed - 1))
		else
			hsp = 0
		
		if place_meeting(x + hsp * 2, y, obj_hallway)
		or (scr_solid(x + image_xscale, y) && !place_meeting(x + image_xscale, y, obj_slope))
			image_xscale *= -1
	}
	
	else if object_index == obj_bananacharger
	{
		movespeed = 0
		if sprite_index != spr_banana_chargestart
			movespeed = 8
		hsp = image_xscale * movespeed
		
		if place_meeting(x + hsp * 2, y, obj_hallway)
		or (scr_solid(x + sign(hsp), y) && !place_meeting(x + sign(hsp), y, obj_slope))
			image_xscale *= -1
	}
	
	else if object_index == obj_ancho
	{
		if sprite_index != spr_chargestart
			hsp = image_xscale * (movespeed + (global.baddiespeed - 1))
		else
			hsp = 0
		
		if scr_solid(x + hsp, y) && !place_meeting(x + hsp, y, obj_slope)
		{ 
			state = states.stun
			stunned = 100
		}
	}
	
	else if object_index == obj_ninja
	{
		if OLD_GAMEPLAY
		{
			hsp = image_xscale * ((movespeed * 2) + (global.baddiespeed - 1))
			image_speed = 0.35
		
			if place_meeting(x + hsp * 2, y, obj_hallway)
			or (scr_solid(x + image_xscale, y) && !place_meeting(x + image_xscale, y, obj_slope))
				image_xscale *= -1
		
			if !((grounded or (grounded && !place_meeting(x,y,obj_platform)))) && hsp < 0
				hsp += 0.1
			else if !((grounded or (grounded && !place_meeting(x,y,obj_platform)))) && hsp > 0
				hsp -= 0.1

			sprite_index = spr_ninja_attack
			if grounded && vsp >= 0
			{
				state = states.walk
				sprite_index = walkspr
			}
		}
		else
		{
			inv_timer = 5
			hsp = image_xscale * 2
			if grounded && vsp > 0
			{
				state = states.walk
				sprite_index = idlespr
			}
			if alarm[4] == -1
				alarm[4] = 5
		}
	}
}
