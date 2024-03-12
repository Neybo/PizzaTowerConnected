if ds_list_find_index(global.saveroom, id) == -1
{
	repeat 4
	{
		with instance_create(x + sprite_width / 2, y + sprite_height / 2, obj_metaldebris)
		{
			sprite_index = spr_barrelblockdebris
			momentum = other.momentum;
		}
	}
	ds_list_add(global.saveroom, id)
	scr_soundeffect(sfx_breakblock);
}

