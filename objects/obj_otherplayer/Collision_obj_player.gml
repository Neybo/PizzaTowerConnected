if global.pvp && 
((pvp && pvp_cooldown <= 0) 
|| gms_self_admin_rights() > 0) 
&& !pause 
&& (gms_other_admin_rights(player_id) < 1 || room == rm_pvparena)
&& !global.racing
{
	with other
	{
		if !other.hurted && other.state != states.hurt && other.state != states.knightpepslopes 
		&& other.state != states.knightpep && other.state != states.tumble
		&& other.state != states.fireass && other.state != states.bombpep && !other.cutscene 
		&& !other.hurted && !hurted && other.state != states.grabbed 
		&& state == states.handstandjump && other.state != states.punch 
		&& other.state != states.handstandjump
		{
			movespeed = 0
			image_index = 0
			sprite_index = spr_haulingstart
		
			state = states.grab
			
			baddiegrabbedID = obj_otherplayer
			
			gms_p2p_send(p2p.pvp_grab, other.player_id);
			other.pvp_cooldown = 12;
		}
		
		if state == states.freefall && !other.hurted && other.state != states.stunned 
		&& other.state != states.hurt && !hurted
		{
			gms_p2p_send(p2p.pvp_squish, other.player_id);
			other.pvp_cooldown = 18;
			
			if (global.hp > 0)
				with (obj_pvparena)
				 damagedealt += 1;
		}

		if state == states.punch
		&& string_contains(sprite_get_name(sprite_index), "uppercut") 
		&& !hurted && !other.hurted
		{
			gms_p2p_send(p2p.pvp_punch, other.player_id);
			other.pvp_cooldown = 15;
			
			if (global.hp > 0)
				with (obj_pvparena)
				 damagedealt += 1;
		}
	}
}