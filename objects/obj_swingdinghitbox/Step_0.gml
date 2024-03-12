x = playerid.x
y = playerid.y
image_xscale = playerid.xscale

with playerid
{
	if (state != states.grab or sprite_index != spr_swingding) && state != states.punch
		instance_destroy(other)
}
