if obj_dogmount.visible
{
	image_alpha = 1;
	x = -99999
	y = -99999
	sprite_index = spr_cafe_dogblockoff	
}
else
{
	sprite_index = spr_cafe_dogblockon
	x = xstart
	y = ystart
	
	if place_meeting(x, y, obj_player)
	{
		with obj_player
			scr_pushout(-1);
	}
	
	if place_meeting(x, y, obj_otherplayer)
		image_alpha = 0.5;
	else
		image_alpha = 1;
}