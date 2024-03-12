playerid = obj_player;
image_xscale = playerid.xscale;
image_speed = 0.5

spd = image_xscale * 25
spdh = 0

pistol = false;
shotgun = false;
down = false;

oob = false;
if !point_in_camera(x, y, view_camera[0])
	oob = true;
