var _dir = point_direction(x, y, 110, 80);
if combo
	_dir = point_direction(x,y, 800, 150);
	
hsp = lengthdir_x(16, _dir);
vsp = lengthdir_y(16, _dir);
x += hsp;
y += vsp;

var outofx = x < 140;
var outofy = y < 120;

if combo
{
	outofx = x > 780;
	outofy = y < 190;
}

if outofx && outofy
{
	if (!combo)
		with obj_camera
			collect_shake += 10;
	instance_destroy();
}

if !point_in_camera(x + camera_get_view_x(view_camera[0]), y + camera_get_view_y(view_camera[0]), view_camera[0])
	instance_destroy();
