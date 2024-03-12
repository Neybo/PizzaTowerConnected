function scr_heatup()
{
	if (!global.heatmeter)
	exit;
	global.baddiespeed += 1
	if global.stylethreshold >= 2
	{
		with obj_heatafterimage
			visible = true
	}
	
	if OLD_GAMEPLAY
	{
		with obj_tv
		{
			message = "HEAT UP!!"
			alarm[2] = 200
			showtext = true
		}
	}
	
	with obj_stylebar
	{
		toggle = true
		alarm[0] = 5
	}
}

