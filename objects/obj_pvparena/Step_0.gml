if (global.hp <= 0 && !obj_player.cutscene)
{
	with (obj_player)
	{
		cutscene = true;
		with instance_create(0, 0, obj_cutscene_handler)
		{
			var player = other.id
			scene_info = 
			[
				[cutscene_taxi_start, player], 
				[cutscene_waitfor_sprite, player], 
				[cutscene_set_sprite, player, spr_player_outofpizza2, 0.5, player.xscale], 
				[cutscene_player_check_ground, player], 
				[cutscene_set_sprite, player, spr_player_outofpizza3, 0.5, player.xscale], 
				[cutscene_waitfor_sprite, player], 
				[cutscene_set_sprite, player, spr_player_outofpizza4, 0.35, player.xscale], 
				[cutscene_taxi_end, player, hub_pvp]
			]
	    }
		instance_destroy(other)

	}
}
	
hpcreateelapsed += 1 / 60
elapsedtimelasted += 1 / 60
if (hpcreatetime <= hpcreateelapsed)
{
	if (check_online())
		gms_p2p_send(p2p.pvp_hpkill,0, gms_self_playerid())
	with (instance_create(irandom_range(40, 1200), 400, obj_pizzaslice_hp))
	{
		if (check_online())
			pid = gms_self_playerid()
		vsp = random_range(-3, -9)
		hsp = choose(-2, 2);
	}
	hpcreatetime = irandom_range(40, 60)
	hpcreateelapsed = 0.0
}