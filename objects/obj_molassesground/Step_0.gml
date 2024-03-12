var player = instance_place(x, y, obj_player);
if player
{
	with player
	{
		if vsp < 0
	    {
			if !other.stopped
			{
		        repeat 2
				{
		            with instance_create(x, y + 43, obj_debris)
					{
						sprite_index = spr_molassesgoop
						vsp = min(vsp, 0)
					}
				}
		        vsp /= 2
			}
			other.stopped = true
			
			/*
	        audio_stop_sound(sfx_cheesejump)
	        audio_stop_sound(sfx_jump)
	        scr_soundeffect(sfx_cheesejump)
			*/
	    }
		else
			other.stopped = false
		
	    if hsp != 0 && grounded
	    {
	        with instance_create(x, y + 43, obj_debris)
			{
				sprite_index = spr_molassesgoop
				vsp = min(vsp, 0)
			}
			
	        if !other.stepped
	        {
	            //scr_soundeffect(sfx_cheesefloor)
	            other.stepped = true
	            other.alarm[0] = 8
	        }
	    }
	}
}
