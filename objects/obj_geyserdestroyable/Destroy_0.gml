if ds_list_find_index(global.saveroom, id) == -1
{
	repeat 4
	{
		with instance_create(x + sprite_width / 2, y + sprite_height / 2, obj_debris)
		{
			sprite_index = spr_geyserdestroyable_debris;
			
			image_xscale = abs(other.image_xscale);
			image_yscale = abs(other.image_yscale);
			
			momentum = [0, -8];
		}
	}
	
	scr_soundeffect(sfx_breakblock)
	ds_list_add(global.saveroom, id)
}

