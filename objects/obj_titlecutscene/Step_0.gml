if drop
	scr_collide()

if x > 960 && !instance_exists(obj_fadeout)
{
	instance_create(x,y,obj_fadeout)
	with obj_player
	{
		targetDoor = "A";
		targetRoom = hub_room1;
	}
}

if sprite_index == spr_pepcooter && !instance_exists(obj_superdashcloud)
	instance_create(x - 100, y, obj_superdashcloud)

