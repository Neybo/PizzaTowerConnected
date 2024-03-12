if surface_exists(surf)
{
	surface_set_target(surf);
	draw_clear_alpha(c_black, 1);
	draw_set_blend_mode(bm_subtract);
	
	draw_set_alpha(0.25);
	draw_set_color(c_white);
	with obj_player
		draw_circle(x + random_range(-1, 1), y + random_range(-1, 1), 300 + random_range(-1, 1), false);
	
	draw_set_color(c_white);
	draw_set_alpha(0.5);
	with obj_player
		draw_circle(x + random_range(-1, 1), y + random_range(-1, 1), 250 + random_range(-1, 1), false);
	
	draw_set_blend_mode(bm_normal);
	surface_reset_target();
	
	draw_surface_ext(surf, 0, 0, 1, 1, 0, c_white, image_alpha);
	draw_set_alpha(1);
}
else
{
	surf = surface_create(room_width, room_height);
	surface_set_target(surf);
	draw_clear_alpha(c_black, 0);
	surface_reset_target();
}

