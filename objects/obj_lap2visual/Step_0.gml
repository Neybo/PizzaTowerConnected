if (active)
{
	if (down)
	{
		var ty = 24;
		y = Approach(y, ty, movespeed);
		if (y >= ty && alarm[0] == -1)
			alarm[0] = 80;
	}
	else
	{
		ty = -sprite_height;
		y = Approach(y, ty, movespeed);
		if (y <= ty)
			instance_destroy();
	}
	x = 960 / 2;
}

//palettes getting figured out
var number = (global.lap + 1)
var list_size = 7; // set the list size
var remainder = number mod list_size; // calculate the remainder of the number divided by the list size
if (remainder == 0) { // if the remainder is zero, return the list size
    paletteselect = list_size
} else { // otherwise, return the remainder
    paletteselect = remainder
}

visible = active