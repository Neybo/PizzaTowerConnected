if ds_list_find_index(global.saveroom, id) == -1
{
	var sndplay = choose(sfx_breakblock);
	scr_soundeffect(sndplay);
	
	with obj_rockblock
	{
		if point_distance(x + sprite_width / 2, y + sprite_height / 2, other.x + other.sprite_width / 2, other.y + other.sprite_height / 2) <= sprite_width
		&& id != other.id
		{
			destroy = true;
			alarm[1] = 8;
		}
	}
	
	repeat 7
	{
		with instance_create(x + sprite_width / 2, y + sprite_height / 2, obj_debris)
			sprite_index = spr_rockdebris
	}
	
	ds_list_add(global.saveroom, id);
}

