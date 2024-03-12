function ledge_bump(_hsp = hsp)
{
	// Clip up before bump
	if FINAL_GAMEPLAY
	{
		var ht = 14;
		if vsp < 0
			ht = 12;
		
		if (scr_solidwall(x + xscale, y) or scr_solid_slope(x + _hsp, y)) 
		&& !scr_solid(x + xscale, y - ht)
		{
			vsp = 0;
			
			var yy = 0;
			while scr_solid(x + xscale, y + yy) // this is a little bs
			{
				yy--;
			}
			
			y += yy;
			
			if REMIX_GAMEPLAY 
				with obj_camera
					pancur[1] -= yy;
			return true;
		}
	}
	return false;
}

