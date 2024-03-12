image_alpha = place_meeting(x, y, obj_otherplayer) ? 0.5 : 1;
if destroy
{
	with obj_rockblock
	{
		if point_distance(x + sprite_width / 2, y + sprite_height / 2, other.x + other.sprite_width / 2, other.y + other.sprite_height / 2) <= sprite_width
			destroy = true;
	}
}

