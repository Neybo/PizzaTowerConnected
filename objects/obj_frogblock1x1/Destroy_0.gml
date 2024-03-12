with instance_create(x + sprite_width / 2, y + sprite_height / 2, obj_sausageman_dead)
{
	sprite_index = other.spr_dead;
	image_xscale = other.image_xscale;
	image_yscale = other.image_yscale;
	sugary = true;
}
	global.combotime += 5
	global.combotime = clamp(global.combotime, 0, 60)
	scr_soundeffect(sfx_killenemy)
ds_list_add(global.saveroom, id);
