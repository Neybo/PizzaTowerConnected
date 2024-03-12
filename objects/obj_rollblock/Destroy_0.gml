if ds_list_find_index(global.saveroom, id) = -1 
{
	scr_secretdebris(true, $00C058);
	
	scr_soundeffect(sfx_breakblock)
	
	ds_list_add(global.saveroom, id) 
}
