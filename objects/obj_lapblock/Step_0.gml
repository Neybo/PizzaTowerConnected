// break block
if !broken && !global.snickchallenge
{
	var player = instance_nearest(x + 48, y + 48, obj_player);
	if (player && distance_to_object(player) < 96) || FINAL_GAMEPLAY
	{
		if (player.state == states.backbreaker && player.sprite_index == player.spr_taunt) || FINAL_GAMEPLAY
		{
			if (OLD_GAMEPLAY)
				scr_soundeffect(sfx_secretwall);
			broken = true;
			y = -9999;
			
			ds_list_add(global.saveroom, id);
		}
	}
}

// alpha
if broken && layer_exists(mylayer)
{
	alpha = lerp(alpha, 0, 0.1);
	if alpha < 0.1
	{
		layer_shader(mylayer, -1);
		layer_set_visible(mylayer, false);
		mylayer = -1;
	}
}

