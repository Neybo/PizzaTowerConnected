if !active
{
	x = xstart
	y = ystart
	mask_index = spr_minipillarwoke
	sprite_index = spr_woke
	
	image_alpha = place_meeting(x, y, obj_otherplayer) ? 0.5 : 1;
}
else
{
	x = -10000
	y = -10000
	sprite_index = spr_sleep
	image_alpha = 1;
}

