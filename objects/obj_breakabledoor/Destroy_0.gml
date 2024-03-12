repeat 8
{
	with instance_create(x + sprite_width / 2, y + sprite_height / 2, obj_wooddebris)
	{
		image_xscale = abs(other.image_xscale);
		image_yscale = abs(other.image_yscale);
		
		sprite_index = spr_breakabledoordebris;
		momentum = other.momentum;
	}
}

scr_soundeffect(sfx_breakblock);
ds_list_add(global.saveroom, id)

