pal_swap_set(spr_peppalette, 1, 0)
draw_self();
if (global.blurafterimage)
	scr_drawtexture(sprite_index, image_index, x, y, image_xscale, 
	image_yscale, image_angle, image_blend, image_alpha, tex)
pal_swap_reset()