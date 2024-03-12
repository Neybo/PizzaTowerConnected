if instance_exists(obj_player)
{
	x = obj_player.x;
	y = obj_player.y;

	if global.stylethreshold < 2
	{
		visible = false;
		is_visible = false;
	}
	else
	{
		visible = obj_player.visible;
		is_visible = true;
	}
}

if place_meeting(x, y, obj_secretportal) or place_meeting(x, y, obj_secretportalstart)
    visible = false

if room == rank_room
	visible = false;

if global.stylethreshold == 2
	alpha = 0.25;
if global.stylethreshold >= 3
	alpha = 0.5;

Vspeed = random_range(-1, 1);
Hspeed = random_range(-1, 1);
alarm[0] = 10;
visible = false;
