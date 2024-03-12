if ds_list_find_index(global.baddieroom, id) == -1
{
	scr_soundeffect(sfx_breakblock)
	repeat 6 with instance_create(x + sprite_width / 2, y + sprite_height / 2, obj_wooddebris)
		sprite_index = spr_breakabledoordebris;
	ds_list_add(global.baddieroom, id) 
}

