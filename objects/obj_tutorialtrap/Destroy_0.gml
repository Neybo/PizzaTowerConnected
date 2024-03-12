scr_soundeffect(sfx_breakblock)

repeat 4
	instance_create(x+ 16,y,obj_debris)

tile_layer_delete_at(1, x, y);
__background_set( e__BG.Index, 2, trapscreen2 );