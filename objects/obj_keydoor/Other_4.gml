sprite_index = spr_locked
if place_meeting(x, y, obj_player)
	sprite_index = spr_open
if ds_list_find_index(global.saveroom, id) != -1
	sprite_index = spr_open

