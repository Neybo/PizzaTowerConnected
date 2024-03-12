//Mach3
with other
{
	if state != states.gotoplayer && state != states.actor && state != states.parry 
	&& state != states.backbreaker //&& state != states.machslide
	{
		var changecoord = true;
		if place_meeting(x, y, obj_superspring) or OLD_GAMEPLAY
			changecoord = false;
		
		with instance_create(x, y, obj_jumpdust)
			image_xscale = other.image_xscale;
		
		if grounded && state == states.pogo && (key_attack or FINAL_GAMEPLAY)
		{
			if other.image_xscale != 0
				xscale = sign(other.image_xscale)
			flash = true
			
			alarm[0] = 50
			
			scr_soundeffect(sfx_noisewoah)
			state = states.Sjumpprep
			image_index = 0
			sprite_index = spr_playerN_jetpackstart
			hsp = 0
			vsp = 0
			with instance_create(x, y, obj_jumpdust)
				image_xscale = other.xscale
		}
		
		else if (state == states.boxxedpep or state == states.boxxedpepjump or state == states.boxxedpepspin)
		&& FINAL_GAMEPLAY
		{
			
		}
		
		else if (grounded && (state == states.mach1 or state == states.mach2 
		or (state == states.handstandjump && (-key_left or key_right) && character == "S")) 
		&& key_attack)
		or (FINAL_GAMEPLAY && (sprite_index != spr_dashpadmach or spr_dashpadmach == spr_move) && alarm[0] <= 0)
		{
			scr_transfobump(false);
			if other.image_xscale != 0
				xscale = sign(other.image_xscale)
			
			machhitAnim = false
			state = states.mach3
			image_index = 0;
			
			if FINAL_GAMEPLAY && spr_dashpadmach != spr_move && !(character == "N" && noisetype == 0)
				sprite_index = spr_dashpadmach
			else
			{
				sprite_index = OLD_GAMEPLAY ? spr_mach4 : spr_crazyrun
				alarm[0] = 20
			}
			instance_create(x, y, obj_jumpdust)
			
			if movespeed < 14
				movespeed = 14
			else if FINAL_GAMEPLAY
				movespeed += 0.5
			hsp = xscale * movespeed
		
			if OLD_GAMEPLAY
				flash = true
		}
		
		else if grounded && state == states.mach3 && key_attack && OLD_GAMEPLAY
		{
			flash = true
			if movespeed < 14
				movespeed = 14
			instance_create(x, y, obj_jumpdust)
		}
	
		if changecoord
		{
			y = other.y - 14;
			
			// snap to ground, since the fucking sugary spire dashpads put you mid air
			// if i sound mildly annoyed it's because i am
			for(var i = 0; i < 64; i++)
			{
				if scr_solid_player(x, y + i + 1)
				{
					y += i;
					vsp = 0;
					break;
				}
			}
		}
	}
}

