function scr_transfobump(_setstate = true)
{
	if state == states.cotton
	{
		// cotton
		scr_soundeffect(sfx_cottongone);
		with instance_create(x, y, obj_genericpoofeffect)
			sprite_index = spr_poofeffectcotton;
		
		if _setstate
		{
			alarm[5] = 2;
			alarm[7] = 60;
			state = states.normal;
		}
	}
	else if state == states.bombpep && sprite_index != spr_bombpepend
	{
		scr_soundeffect(sfx_bombpep2);
		instance_create(x, y, obj_bombexplosion);
		
		if _setstate
			sprite_index = spr_bombpepend;
	}
	else if state == states.mort
	{
		// holy shit he fucking DIES
		repeat 6 with instance_create(x, y, obj_debris)
			sprite_index = spr_feather;
	}
	else if state == states.cheesepep or state == states.cheesepepstick or state == states.cheesepepfling or state == states.cheesepepjump or state == states.cheesepeplaunch or state == states.cheesepepstickside or state == states.cheesepepstickup
	{
		scr_soundeffect(sfx_loseknight)
		repeat 8
			instance_create(x,y,obj_slimedebris)
		if _setstate
		{
			scr_soundeffect(sfx_bumpwall);
			hsp = 5 * -xscale;
			vsp = -3;
			image_index = 0;
			flash = true;
			state = states.bump;
			
			alarm[5] = 2;
			alarm[7] = 60;
			hurted = true;
		}
			
	}
	else if state == states.boxxedpep or state == states.boxxedpepjump or state == states.boxxedpepspin
	{
		scr_soundeffect(sfx_loseknight)
		grav = basegrav
		
		for(var i = 0; i < 4; i++)
		{
			with instance_create(x, y, obj_boxxeddebris)
				image_index = i;
		}
		
		if _setstate
		{
			hsp = -xscale * 4;
			vsp = -5
			
			state = states.bump
			
			alarm[5] = 2
			alarm[7] = 120
			alarm[8] = 60
			hurted = true
		}
	}
	else if (state == states.knightpep or state == states.knightpepattack or state == states.knightpepslopes)
	&& sprite_index != spr_knightpepstart
	{
		// knight armor debris
		if character == "P" or character == "N" or character == "SP" or character == "PP"
		{
			var debrisspr = spr_knightdebris;
			switch character
			{
				case "N": sprite_index = spr_playerN_knightarmor; break;
				case "SP": sprite_index = spr_knightdebrisSP; break;
			}
			
			for(var i = 0; i < sprite_get_number(debrisspr); i++)
			{
				with instance_create(x, y, obj_knightdebris)
				{
					image_index = i;
					sprite_index = debrisspr;
				}
			}
		}
		else repeat 6
			instance_create(x, y, obj_metaldebris);
		scr_soundeffect(sfx_loseknight);
	
		// bump
		if _setstate
		{
			scr_soundeffect(sfx_bumpwall);
			hsp = 5 * -xscale;
			vsp = -3;
			image_index = 0;
			flash = true;
			state = states.bump;
			
			alarm[5] = 2;
			alarm[7] = 60;
			hurted = true;
		}
		return true;
	}
	else
		return false;
}