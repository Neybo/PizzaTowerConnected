event_inherited();
if sprite_index == spr_shrimp_throw && image_index < 8
{
	var yy = -62;
	switch floor(image_index)
	{
		case 0: yy = -25; break;
		case 1: yy = -32; break;
		case 2: yy = -45; break;
		case 3: yy = -55; break;
		case 4: yy = -60; break;
	}
	
	if flash
		draw_set_flash(true);
	draw_sprite_ext(spr_junk, trashimg, x + 10, y + yy, image_xscale, 1, image_angle, c_white, 1);
	draw_set_flash(false);
}

