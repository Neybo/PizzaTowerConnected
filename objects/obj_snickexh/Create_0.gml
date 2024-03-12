event_inherited();

maxspeed = 10
depth = obj_tv.depth + 1;

appeartimer = room_speed * 5;
gotoplayer = 0;
appear = 0;
popfrom = 0;
xcam = 960;
ycam = 540;
lockcam = false;
appeared = false;

if global.snickchallenge && global.snickrematch && OLD_GAMEPLAY
{
	if instance_exists(obj_snickexg)
		alarm[3] = 50;
	else
	{
		with obj_tv
		{
			showtext = true
			message = "SNUCK IS COMING"
			alarm[2] = 100
		}
	}
}

