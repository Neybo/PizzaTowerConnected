with obj_player
{
	if place_meeting(x + xscale, y, other) && state == states.barrel
		instance_destroy(other);
}

