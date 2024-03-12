if ds_list_find_index(global.baddieroom, id) == -1
{
	scr_soundeffect(sfx_killjuice);
	with instance_create(x, y, obj_juicepuddle)
	{
		paletteselect = other.paletteselect;
		vsp = -6;
	}

	repeat 6
	{
		with instance_create(x, y, obj_baddiegibs)
		{
			sprite_index = spr_juicedebris;
			image_index = random(image_number);
		}
	}
}
event_inherited();

