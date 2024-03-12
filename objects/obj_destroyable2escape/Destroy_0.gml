if ds_list_find_index(global.saveroom, id) == -1 && global.panic
{
	repeat 6 with instance_create(x + sprite_width / 2, y + sprite_height / 2, obj_pizzadebris)
	{
		image_xscale = abs(other.image_xscale);
		image_yscale = abs(other.image_yscale);
			
		if other.sprite_index == spr_destroyable2escape_ss
			sprite_index = spr_debrisescape_ss
		else if other.sprite_index == spr_destroyable2escapeNEW_ss
			sprite_index = spr_smallbreak2escapedebris_ss;
		else
			sprite_index = spr_debrisescape
			
		momentum = other.momentum;
	}
	create_baddiegibsticks(x + sprite_width / 2, y + sprite_height / 2);
	
	with instance_create(x, y, obj_collect)
	{
		ID = other.id;
		depth = other.depth;
		sprite_index = scr_collectsprite(false, true);
	}
	tile_layer_delete_at(1, x, y);
		
	scr_soundeffect(sfx_breakblock)
}

