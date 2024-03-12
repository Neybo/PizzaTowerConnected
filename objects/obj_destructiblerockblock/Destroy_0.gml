if ds_list_find_index(global.saveroom, ID) == -1
{
	scr_soundeffect(sfx_breakblock);
	
	if OLD_GAMEPLAY
		instance_create(x + sprite_width / 2, y + sprite_height / 2, obj_playerexplosion);
	
	with obj_rockblock
	{
		if point_distance(x + sprite_width / 2, y + sprite_height / 2, other.x + other.sprite_width / 2, other.y + other.sprite_height / 2) <= sprite_width
		{
			destroy = true;
			alarm[1] = 8;
		}
	}
	
	repeat 7
	{
		with instance_create(x + sprite_width / 2, y + sprite_height / 2, obj_debris)
		{
			image_xscale = abs(other.image_xscale);
			image_yscale = abs(other.image_yscale);
			
			sprite_index = spr_tntblockdebris;
		}
	}
	ds_list_add(global.saveroom, ID);
}

