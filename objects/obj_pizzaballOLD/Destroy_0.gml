if ds_list_find_index(global.saveroom, id) == -1
{
	with instance_create(x, y, obj_pizzaball_slices)
	{
		if global.golfhit <= 1
		{
			count = 30;
			spd = 5;
		}
		else if global.golfhit < 10
			count = 10;
		else if global.golfhit < 20
			count = 5;
		else
			count = 1;
	}
	global.golfhit = 0;
	ds_list_add(global.saveroom, id)
	
	with (obj_pizzaballblock)
		instance_destroy()
	
	if OLD_GAMEPLAY
		scr_sleep(50)
}
scr_soundeffect(sfx_killenemy)

repeat 3
{
	instance_create(x,y,obj_baddiegibs)
	instance_create(x,y,obj_slapstar)
}
instance_create(x, y + 30, obj_bangeffect)

with (obj_camera)
{
	shake_mag=5;
	shake_mag_acc=20/room_speed;
	
	targetoverride = noone;
	targetgoingback = true;
}