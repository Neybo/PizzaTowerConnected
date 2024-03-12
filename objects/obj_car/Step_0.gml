switch state
{
	case states.normal:
		if place_meeting(x, y, obj_player)
		{
			var b = instance_place(x, y, obj_player);
			if b.state == states.mach3
			{
				player_inst = b;
				hsp = sign(player_inst.hsp);
					
				if player_inst.hsp == 0
					hsp = player_inst.xscale;
					
				instance_destroy(inst);
				scr_soundeffect(sfx_killingblow);
				
				if OLD_GAMEPLAY
				{
					scr_sleep(50);
					instance_destroy();
				}
				else
				{
					if global.hitstun
						with b
						{
							hitX = x;
							hitY = y;
							hitLag = 10;
							tauntstoredmovespeed = movespeed;
							tauntstoredsprite = sprite_index;
							tauntstoredstate = state;
							tauntstoredvsp = vsp;
						
							state = states.hitlag;
						}
				
					hitX = x;
					hitY = y;
					hitLag = 10;
					state = states.hitlag;
				}
			}
		}
		break;
	
	case states.hitlag:
		x = hitX + irandom_range(-1, 1);
		y = hitY + irandom_range(-1, 1);
		
		if hitLag > 0
			hitLag--;
		else
		{
			x = hitX;
			y = hitY;
			instance_destroy();
		}
		break;
}