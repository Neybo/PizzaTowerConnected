function scr_heatdown()
{
	if (!global.heatmeter)
	exit;
	global.baddiespeed = max(global.baddiespeed - 1, 1);
	if global.stylethreshold < 2
	{
		with obj_heatafterimage
			visible = false
	}
	
	if OLD_GAMEPLAY
	{
		with obj_tv
		{
			message = "HEAT DOWN..."
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

