if ds_list_find_index(global.saveroom, id) == -1
{
	repeat 4
	{
		with instance_create(x + sprite_width / 2, y + sprite_height / 2, obj_debris)
		{
			sprite_index = spr_secretdebris;
			image_blend = choose(#88A8C8, c_white);
		}
	}
	scr_soundeffect(sfx_breakblock)
	ds_list_add(global.saveroom, id) 
}
