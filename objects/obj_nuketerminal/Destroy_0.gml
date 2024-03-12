if (ds_list_find_index(global.saveroom, id) == -1)
{
    instance_create_unique(0, 0, obj_wartimer)
    scr_soundeffect(sfx_warup)
    with (obj_wartimer)
    {
        addseconds += other.seconds
        while (other.minutes > 0)
        {
            other.minutes--
            addseconds += 70
        }
        alarm[0] = -1
        alarm[2] = 1
    }
    for (var i = 0; i < sprite_get_number(spr_warterminal_debris); i++)
    {
        with (instance_create(x, y, obj_parentparticle))
		{
			sprite_index = spr_warterminal_debris
            image_index = i
			vsp = irandom_range(-6, -4)
			grav = 1
			hsp = irandom_range(-4, 4)
		}
	}
    tile_layer_delete_at(1, x, y)
    tile_layer_delete_at(1, (x + 32), y)
    tile_layer_delete_at(1, (x + 32), (y + 32))
    tile_layer_delete_at(1, x, (y + 32))
	if room != war_lap
		ds_list_add(global.saveroom, id) 
}
