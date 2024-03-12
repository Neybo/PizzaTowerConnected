//Draw
if haspalette && sprite_exists(spr_palette)
	pal_swap_set(spr_palette, paletteselect, false)
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
pal_swap_reset();
if patternfucking
	scr_drawtexture(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha)