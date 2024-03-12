if ds_list_find_index(global.saveroom, id) == -1
{
	repeat 6
		instance_create(x + irandom(sprite_width), y + irandom(sprite_height), obj_glassdebris)
	
	scr_soundeffect(sfx_breakblock)
	tile_layer_delete_at(1, x, y);
	ds_list_add(global.saveroom, id) 
}

