if ds_list_find_index(global.saveroom, id) = -1
{
	repeat 6
	{
		with instance_create(x + sprite_width / 2, y + sprite_height / 2, obj_debris)
		{
			sprite_index = spr_secretblockdebris
			image_xscale = abs(other.image_xscale)
			image_yscale = abs(other.image_yscale)
			
			momentum = other.momentum;
		}
	}
	
	scr_soundeffect(sfx_breakblock)
}

