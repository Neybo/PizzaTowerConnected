/// @description autotile
if image_yscale <= 1
{
	var up = place_meeting(x, y - 32, obj_ladder);
	var down = place_meeting(x, y + 32, obj_ladder);
	if up
	{
		if down
			image_index = 0;
		else if (place_meeting(x, y + 32, obj_solid))
		|| place_meeting(x, y + 32, obj_platform)
			image_index = 1;
	}
	else if down
		image_index = 2;
}
autotile = true;
