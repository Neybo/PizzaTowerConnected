instance_create(x, y, obj_bangeffect)
repeat 3
{
	create_particle(x, y, particles.baddiegibs);
	instance_create(x, y, obj_slapstar)
}
	
with obj_camera
{
	alarm[1] = 60;
		
	shake_mag = 3;
	shake_mag_acc = 3 / room_speed;
}
	
with instance_create(x, y, obj_sausageman_dead)
{
	sprite_index = other.spr_dead;
	image_xscale = other.image_xscale;
	image_yscale = other.image_yscale;
	sugary = true;
}
scr_soundeffect(sfx_killenemy)

with obj_minipillar_cardboard
	active = true;
with obj_reverseminipillar_cardboard
	active = true;
with obj_cherrycardboard
	active = true;

