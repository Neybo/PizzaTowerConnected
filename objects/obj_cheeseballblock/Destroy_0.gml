if ds_list_find_index(global.saveroom, id) = -1
{
	repeat 4
	{
		with instance_create(x + sprite_width / 2, y + sprite_height / 2, obj_metaldebris)
			sprite_index = spr_cheeseballblockdebris
	}
	
	with obj_camera
	{
		shake_mag = 20;
		shake_mag_acc = 40 / room_speed;
	}
	gp_vibration(1, 1, 0.8);
	
	scr_soundeffect(sfx_breakmetal)
	ds_list_add(global.saveroom, id) 
}
