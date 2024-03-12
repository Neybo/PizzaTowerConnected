if other.instakillmove
{
	with obj_camera
	{
		shake_mag = 3;
		shake_mag_acc = 3 / room_speed;
	}
	
	scr_soundeffect(sfx_killenemy);
	repeat 3
		instance_create(x, y, obj_slapstar);
	repeat 3
		create_particle(x, y, particles.baddiegibs);
	if FINAL_GAMEPLAY
	{
		instance_create(x, y, obj_genericpoofeffect);
		instance_create(x, y, obj_parryeffect);
	}
	instance_create(x, y, obj_bangeffect);
	
	with instance_create(x, y, obj_sausageman_dead)
		sprite_index = spr_noise_dead;
	instance_destroy();
}

