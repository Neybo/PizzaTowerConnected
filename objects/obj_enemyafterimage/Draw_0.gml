if image_alpha > 0
{
	if sprite_exists(sprite_index)
		draw_sprite_ext(sprite_index, floor(image_index), x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha)
	else
		draw_sprite_ext(spr_player_mach, floor(image_index), x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha)
}

