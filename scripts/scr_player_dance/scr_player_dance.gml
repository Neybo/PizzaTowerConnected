function scr_player_dance()
{
	hsp = 0;
	image_speed = dance_imgspeed;
	
	if sprite_index = spr_idle || sprite_index = spr_fall
		vsp += basegrav;	
	else
		vsp = min(vsp, 0);
	if !dance_dancing
	{
		if grounded  
		{
			if sprite_index == spr_fall
			{
				sprite_index = spr_idle
				image_index = 0
			}
			for (var i = 0; i < dance_length; i++)
			{
				dance_parse(dance_dances[i])
			}
		}
	}
	else
	{
		if spr_taunt == sprite_index
		{
			dance_timer++;
			if dance_timer > 25
			{
				dance_restart(spr_idle)
			}
		}
		else if sprite_index = spr_player_climbstairs
		{
			dance_timer++;
			if dance_timer > 60
			{
				dance_restart(spr_idle)
			}
		}
	    else if sprite_index = spr_jump && sprite_index > 9
		{
			if dance_curpose == dancesfpb.flipmidair
				sprite_index = spr_player_diagonalupthrow
			else
				sprite_index = spr_player_backflip
			image_index = 0
			dance_imgspeed = 0.375
			animEnd = false
		}
		else if sprite_index = spr_breakdancesuper
		{
			dance_timer++;
			
			if dance_timer > 40
			{
				dance_restart(spr_idle)
			}
			if key_down2
				dance_timer = max(dance_timer - 10, 0)
		}
		else if animEnd
		{
			if sprite_index = spr_player_hanstandjump || sprite_index = spr_tackle
			|| sprite_index = spr_player_suplexdance
			{
				dance_restart(spr_idle)	
			}
			if sprite_index = spr_player_diagonalupthrow || sprite_index = spr_backflip
			{
				dance_restart(spr_fall)	
			}
		}
		
	}
	scr_collide();
}
