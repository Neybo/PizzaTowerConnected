if ds_list_find_index(global.saveroom, ID) == -1
{
	instance_create(x + sprite_width / 2, y + sprite_height / 2, obj_playerexplosion);
	
	with obj_rockblock
	{
		if point_distance(x + sprite_width / 2, y + sprite_height / 2, other.x + other.sprite_width / 2, other.y + other.sprite_height / 2) <= sprite_width
		{
			destroy = true;
			alarm[1] = 8;
		}
	}
	
	repeat 6
	with instance_create(x + sprite_width / 2, y + sprite_height / 2, obj_tntblockdebris)
		momentum = other.momentum;
	ds_list_add(global.saveroom, ID);
}

