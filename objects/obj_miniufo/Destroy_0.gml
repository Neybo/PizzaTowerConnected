if ds_list_find_index(global.baddieroom, id) == -1 && OLD_GAMEPLAY
	instance_create(x, y, obj_playerexplosion);
event_inherited();

