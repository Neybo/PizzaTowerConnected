if place_meeting(x, y, obj_otherplayer) && !falling
	image_alpha = 0.5;
else
	image_alpha = 1;

if sprite_index == spr_dissolve && sugary && image_index >= 10
{
	x = -100;
	y = -100;
}

if floor(image_index) >= image_number - 1
{
	if sprite_index == spr_dissolve
	{
		sprite_index = spr_dead;
		falling = true;
		x = -100;
		y = -100;
	}
	if sprite_index == spr_reform
	{
		falling = false;
		sprite_index = spr_idle;
		image_index = 0;
		
		x = xstart;
		y = ystart;
	}
}
if sprite_index == spr_dead && reset > 0
	reset--;

if reset <= 0 && !place_meeting(xstart, ystart, obj_player)
&& !place_meeting(xstart, ystart, obj_pizzaballOLD) && !place_meeting(xstart, ystart, obj_pizzaball)
{
	reset = 100;
	falling = false;
	
	if !sugary
	{
		x = xstart;
		y = ystart;
	}
	sprite_index = spr_reform;
}

