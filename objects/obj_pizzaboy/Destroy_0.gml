scr_failmod(mods.pacifist)
scr_soundeffect(sfx_killenemy)

if OLD_GAMEPLAY
{
	scr_sleep(50);
	repeat 3
		instance_create(x, y, obj_slapstar);
	repeat 3
		create_particle(x, y, particles.baddiegibs);
}

with obj_camera
{
	shake_mag = 3;
	shake_mag_acc = 3 / room_speed;
}

with instance_create(x, y, obj_sausageman_dead)
	sprite_index = other.spr_dead

