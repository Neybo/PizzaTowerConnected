if object_index == obj_escapecollectbig
	ds_list_add(global.escaperoom, owner)
else
	ds_list_add(global.saveroom, owner) 
scr_ghostcollectible()
