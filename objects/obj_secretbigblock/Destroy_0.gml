if ds_list_find_index(global.saveroom, id) = -1
{
	scr_soundeffect(sfx_breakblock)

	ds_list_add(global.saveroom, id) 
	
	scr_cutoff();
	if is_array(layers)
		scr_secretbigdebris(,,,layers);
	else
		scr_secretbigdebris();
}