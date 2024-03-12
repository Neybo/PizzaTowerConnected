if start
{
	yy -= start_spd
	if yy <= 326
	{
		yy = 326;
		start = false;
	}
}
else if finish
{
	yy += finish_spd;
	if yy >= 755
		instance_destroy();
}

if global.panic
	finish = true

var hide = false;
with obj_player
{
	if x > _camx + other.xx && y > _camy + other.yy
		hide = true;
	if (state != states.normal or abs(hsp) > 0) && state != states.actor
		other.alarm[0] = 60;
}
if alarm[0] > 0
	hide = true;

if hide
{
	if image_alpha > 0.2
		image_alpha -= 0.1;
	else
		image_alpha = 0.2;
}
else if image_alpha < 1
	image_alpha += 0.1;
else
	image_alpha = 1;

if room == timesuproom or !global.showgnomelist
	visible = false;
else
	visible = true;

