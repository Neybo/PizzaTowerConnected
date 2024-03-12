
if ds_list_find_index(global.saveroom, id) == -1 && !global.snickchallenge
{
	repeat 6 with instance_create(x + sprite_width / 2, y + sprite_height / 2, obj_pizzadebris)
	{
		image_xscale = abs(other.image_xscale);
		image_yscale = abs(other.image_yscale);
		
		if other.sprite_index == spr_halloweensmallblock
		or other.sprite_index == spr_xmasblock
			sprite_index = spr_halloweendebris;
		else if other.sprite_index == spr_destroyable2_ss
			sprite_index = spr_pizzadebris_ss;
		else if other.sprite_index == spr_destroyable2_NEW_ss
			sprite_index = spr_pizzadebris_NEW_ss;
		else if other.sprite_index == spr_destroyable2_PP
			sprite_index = spr_pizzadebris_PP;
		else
			sprite_index = spr_pizzadebris;
		
		momentum = other.momentum;
	}
	
	if other.sprite_index == spr_destroyable2_NEW
	{
		with instance_create(x + sprite_width / 2, y + sprite_height / 2, obj_parryeffect)
	        sprite_index = spr_pizzablockdead
	    scr_sleep(5)
	}
	
	create_baddiegibsticks(x + sprite_width / 2, y + sprite_height / 2);
	
	with instance_create(x, y, obj_collect)
	{
		ID = other.id;
		depth = other.depth;
	}
	tile_layer_delete_at(1, x, y);
	
	scr_soundeffect(sfx_breakblock)
}
