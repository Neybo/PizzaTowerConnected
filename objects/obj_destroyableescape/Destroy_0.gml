if ds_list_find_index(global.saveroom, id) = -1 && global.panic
{
	var rep = OLD_GAMEPLAY ? 4 : 2; // amount of debris
	repeat rep
	{
		with instance_create(x + sprite_width / 2, y + sprite_height / 2, obj_debris)
		{
			image_xscale = abs(other.image_xscale);
			image_yscale = abs(other.image_yscale);
			
			if other.sprite_index == spr_destroyableescapeNEW_ss
				sprite_index = spr_debrisescapeNEW_ss;
			else if other.sprite_index == spr_destroyableescape_ss
				sprite_index = spr_debrisescape_ss;
			else
				sprite_index = spr_debrisescape;
			
			momentum = other.momentum;
		}
	}
	tile_layer_delete_at(1, x, y);
		
	scr_soundeffect(sfx_breakblock)

	ds_list_add(global.saveroom, id) 
}