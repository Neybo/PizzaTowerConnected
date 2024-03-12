x += image_xscale * 6
depth = -1

if scr_solid(x, y) or place_meeting(x, y, obj_slope)
	instance_destroy()
