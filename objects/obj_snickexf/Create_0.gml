event_inherited();

maxspeed = 1.25
cantp = room_speed * 3

if global.snickrematch && OLD_GAMEPLAY
{
	with obj_tv
	{
		showtext = true
		message = "SNACK IS COMING"
		alarm[2] = 100
	}
}

