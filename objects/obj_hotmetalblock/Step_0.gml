with obj_player
{
	if (state == states.knightpepslopes or state == states.rocket) && (place_meeting(x + hsp, y, other) or place_meeting(x + xscale, y, other))
		instance_destroy(other);
	if (state == states.knightpep or state == states.hookshot) && place_meeting(x, y + 1, other)
		instance_destroy(other);
}
image_alpha = place_meeting(x, y, obj_otherplayer) ? 0.5 : 1;

