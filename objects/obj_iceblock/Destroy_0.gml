if ds_list_find_index(global.saveroom, id) == -1
{
	repeat 6
	{
		with instance_create(x + sprite_width / 2, y + sprite_height / 2, obj_debris)
			sprite_index = spr_icedebris;
	}
	instance_create(x + sprite_width / 2, y + sprite_height / 2, obj_parryeffect)
	ds_list_add(global.saveroom, id)
}

