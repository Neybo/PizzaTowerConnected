if ds_list_find_index(global.saveroom, id) = -1
{
	instance_create(x, y, obj_bangeffect)
	with instance_create(x, y, obj_pizzaslice)
		hsp = 2
	with instance_create(x, y, obj_pizzaslice)
		hsp = -2
	
	repeat 6
	{
		with instance_create(x, y, obj_debris)
		{
			sprite_index = spr_tvdebris
			image_index = random(image_number)
		}
	}
	ds_list_add(global.saveroom, id) 
	scr_soundeffect(sfx_breakblock);
}

