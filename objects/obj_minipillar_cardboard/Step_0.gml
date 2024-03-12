if !active
{
	x = -10000
	y = -10000
	image_alpha = 1
	sprite_index = spr_sleep
}
else
{
	mask_index = spr_minipillarwoke
	sprite_index = spr_woke
	
	x = xstart
	y = ystart
	
	if place_meeting(x, y, obj_player)
	{
		with obj_player
			scr_pushout(-1);
	}
	image_alpha = place_meeting(x, y, obj_otherplayer) ? 0.5 : 1;
}

