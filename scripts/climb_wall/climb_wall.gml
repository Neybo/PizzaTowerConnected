function climb_wall(_hsp = hsp)
{
	var slop = scr_slope();
	
	return (scr_solidwall(x + _hsp, y) or scr_solid_slope(x + _hsp, y)) 
	&& (!slop or scr_solidwall(x + xscale, y - 10))
	&& (!place_meeting(x + _hsp, y, obj_destructibles) or (character == "V" && OLD_GAMEPLAY));
}
