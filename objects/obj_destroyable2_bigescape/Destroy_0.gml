

if ds_list_find_index(global.saveroom, id) == -1 && global.panic
{
	repeat 6 with instance_create(x + sprite_width / 2, y + sprite_height / 2, obj_debris)
	{
		image_xscale = abs(other.image_xscale)
		image_yscale = abs(other.image_yscale)
		
		if other.sprite_index == spr_destroyable2bigescape_ss
			sprite_index = spr_bigdebrisescape_ss
		else if other.sprite_index == spr_destroyable2bigescapeNEW_ss
			sprite_index = spr_bigbreak2escapedebris_ss
		else if other.sprite_index == spr_bigbreakableescape_PP
			sprite_index = spr_bigdebrisescape_PP
		else
			sprite_index = spr_bigdebrisescape
		
		momentum = other.momentum;
	}
	
	if content == noone
	{
		with instance_create(x + sprite_width / 2, y + sprite_height / 2, obj_pizzaslice)
			hsp = 2
		with instance_create(x + sprite_width / 2, y + sprite_height / 2, obj_pizzaslice)
			hsp = -2
	}
	else
		instance_create(x + sprite_width / 2, y + sprite_height / 2, content);
	
	create_baddiegibsticks(x + sprite_width / 2, y + sprite_height / 2);
	
	/*
	tile_layer_delete_at(1, x, y);
	tile_layer_delete_at(1, x+32, y);
	tile_layer_delete_at(1, x+32, y+32);
	tile_layer_delete_at(1, x, y+32);
	*/
		
	scr_soundeffect(sfx_breakblock)
	ds_list_add(global.saveroom, id)
}