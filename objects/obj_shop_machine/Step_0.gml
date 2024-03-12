// show level name when player near
image_speed = imagespeed
if instance_exists(obj_player)
{
	var p = instance_nearest(x, y, obj_player);
	
	if msg != "" && distance_to_object(p) < 50
	&& p.state != states.gameover && p.state != states.victory
	{
		with obj_tv
		{
			message = other.msg
			showtext = true
			alarm[2] = 2
		}
	}
}