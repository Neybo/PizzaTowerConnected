with (other)
{
	if (!other.collisioned)
	{
		if (direction < 90 || direction > 270)
			obj_player.xscale = -1;
		else
			obj_player.xscale = 1;
	}
	direction -= 180;
	instance_create(obj_player.x + (obj_player.xscale * 20), obj_player.y, obj_bangeffect);
}
if (!collisioned)
	event_user(0);
