/// @description slap
with obj_camera
{
	shake_mag = 3;
	shake_mag_acc = 3 / room_speed;
}
global.boxhp -= 1
scr_soundeffect(sfx_killenemy)

if OLD_GAMEPLAY
	scr_sleep(50)
repeat 3
{
	instance_create(x,y,obj_baddiegibs)
	instance_create(x,y,obj_slapstar)
}

if character == 0
{
	ds_list_shuffle(global.boxlist);
	with obj_presentbox
	{						
		getout = getoutspd;
		outtime = outtimespd;
		sprite_index = spr_present;	
	}
}
else
	sprite_index = spr_present;

with instance_create(x, y, obj_sausageman_dead)
	sprite_index = other.deadspr;
