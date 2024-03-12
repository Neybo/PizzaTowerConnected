if (!drop && !instance_exists(obj_pepperman)) or FINAL_GAMEPLAY
{
	with other
	{
		if scr_transformationcheck()
		{
			if OLD_GAMEPLAY
			{
				if state == states.barrel
				{
					movespeed = 4
					sprite_index = spr_player_barrelslipnslide
					image_index = 0
					
					other.drop = true
					other.vsp = -5
				}
				else if state != states.slipnslide
				{
					event_perform(ev_step_begin, 0)
					sprite_index = spr_slipnslide
					other.drop = true
					other.vsp = -5
					state = states.slipnslide
					if movespeed < 12
						movespeed = 12
				}
			}
			else
			{
				scr_soundeffect(sfx_tumble2)
				event_perform(ev_step_begin, 0)
				sprite_index = spr_slipbanan1;
				other.drop = 1;
				vsp = -11;
				image_index = 0;
				state = states.slipbanan;
				sprite_index = spr_slipbanan1;
				movespeed += 2
		        if (movespeed > 14)
		            movespeed = 14
		        hsp = (movespeed * xscale)
				instance_destroy(other);
			}
		}
	}
}

