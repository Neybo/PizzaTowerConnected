//var player = instance_place(x, y, obj_player);
//if player
//{
//	with player
//	{
//		if vsp < 0
//	    {
//	        repeat 2
//			{
//	            with instance_create(x, y + 43, obj_debris)
//					sprite_index = spr_cheesechunk
//			}
//	        vsp *= 0.5
			
//	        audio_stop_sound(sfx_cheesejump)
//	        audio_stop_sound(sfx_jump)
//	        scr_soundeffect(sfx_cheesejump)
//	    }
		
//		if state == states.climbwall
//			state = grounded ? states.normal : states.jump
		
//	    if hsp != 0 && (floor(image_index) % 4 == 0)
//	    {
//	        with instance_create(x, y + 43, obj_debris)
//				sprite_index = spr_cheesechunk
			
//	        if !other.stepped
//	        {
//	            scr_soundeffect(sfx_cheesefloor)
//	            other.stepped = true
//	            other.alarm[0] = 8
//	        }
//	    }
//	}
//}
