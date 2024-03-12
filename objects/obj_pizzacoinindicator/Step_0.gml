if global.pizzacoin == -coinoffset
{
	scr_setcoin(0);
	global.pizzacoinstart = global.pizzacoin;
}

if instance_exists(obj_weaponmachine)
	visible = true
else if show <= 0
	visible = false

image_alpha = 1;
if show > 0
{
	show -= 1;
	visible = true;
	
	if REMIX_GAMEPLAY
		image_alpha = clamp(show / 5, 0, 1);
}

shake = Approach(shake, 0, 0.25);
if display != global.pizzacoin
{
	display = global.pizzacoin;
	show = 50;
	
	if FINAL_GAMEPLAY
		shake = 3;
}

if !check_online()
	visible = false;


