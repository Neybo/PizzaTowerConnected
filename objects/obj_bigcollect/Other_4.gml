if ds_list_find_index(global.saveroom, id) != -1  
	instance_destroy(id, false);
if global.snickchallenge
	instance_destroy(id, false);

if global.panic || global.wartimer
	image_alpha = 1;
