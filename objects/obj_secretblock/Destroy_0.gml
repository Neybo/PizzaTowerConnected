if ds_list_find_index(global.saveroom, ID) == -1
{
	scr_soundeffect(sfx_breakblock)
	
	if save
		ds_list_add(global.saveroom, ID) 
	
	scr_cutoff();
	if is_array(layers)
		scr_secretdebris(,,,layers);
	else
		scr_secretdebris();
}
