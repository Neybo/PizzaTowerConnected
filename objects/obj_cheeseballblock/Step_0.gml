with obj_player
{
	if state == states.cheeseball && place_meeting(x + xscale, y, other)
		instance_destroy(other);
}
image_alpha = place_meeting(x, y, obj_otherplayer) ? 0.5 : 1;

