if global.panic && !string_startswith(room_get_name(room), "tower")
{
	image_xscale *= -1
	x -= image_xscale * 32
}
