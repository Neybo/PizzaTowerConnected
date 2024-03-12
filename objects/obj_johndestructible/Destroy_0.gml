if (ds_list_find_index(global.saveroom, id) == -1)
{
    repeat (7)
        with instance_create((x + 32), (y + 32), obj_debris)
		{
			sprite_index = spr_johndestructible_debris
			image_index = irandom(7)
		}
	tile_layer_delete_at(1, x, y)
    tile_layer_delete_at(1, (x + 32), y)
    tile_layer_delete_at(1, (x + 32), (y + 32))
    tile_layer_delete_at(1, x, (y + 32))
    fmod_create_instance_one_shot_3d(sfx_breakblock, x, y)
    ds_list_add(global.saveroom, id)
}
