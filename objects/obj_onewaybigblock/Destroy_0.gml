if ds_list_find_index(global.saveroom, id) == -1
{
	if sprite_index == spr_onewaybigblock_NEW
	{
		with instance_create(x, y, obj_sausageman_dead)
		{
	        sprite_index = spr_bigdoughblockdead
			hsp = -other.image_xscale * 5
		}
	}
	else
	{
		repeat 6 with instance_create(x, y, obj_debris)
		{
			image_xscale = abs(other.image_xscale)
			image_yscale = abs(other.image_yscale)
		
			if other.sprite_index == spr_onewayblock_ss
				sprite_index = spr_bigdebris_ss;
			else
				sprite_index = spr_bigdebris;
		
			momentum = other.momentum;
		}
		if sprite_index == spr_onewayblock_ss
		{
			with instance_create(x, y, obj_debris)
			{
				sprite_index = spr_bigdebrisbandage_ss;
				momentum = other.momentum;
			}
		}
	}
	scr_soundeffect(sfx_breakblock)
	ds_list_add(global.saveroom, id)
}
with mysolid
	instance_destroy()
