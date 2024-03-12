if (obj_player.character == "N")
	pal_swap_set(spr_noisepalette, obj_player.paletteselect, false)
else
	pal_swap_set(spr_noisepalette, 0, false)
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
shader_reset()