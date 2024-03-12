var _dir = point_direction(x, y, homeinst.x, homeinst.y);
hsp = lengthdir_x(24, _dir);
vsp = lengthdir_y(24, _dir);
x += hsp;
y += vsp;

if place_meeting(x, y, homeinst)
{
	with homeinst
		collect_shake += 10;
	instance_destroy();
}

