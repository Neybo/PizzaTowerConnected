if instance_exists(obj_endlevelfade)
	exit;

if !global.panic or (instance_exists(obj_snicklevelend) && obj_snicklevelend.alarm[0] > -1)
{
	x = -10000
	y = -10000
	image_alpha = 1;
	
	if !instance_exists(obj_snicklevelend) or !obj_snicklevelend.visible
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
	
	if place_meeting(x, y, obj_otherplayer)
		image_alpha = 0.5;
	else
		image_alpha = 1;
}