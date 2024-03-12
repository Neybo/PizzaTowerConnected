pal_swap_set(spr_palette, paletteselect, 0)
draw_sprite_ext(sprite_index, floor(image_index), x, y, image_xscale, image_yscale, 
image_angle, image_blend, image_alpha)
pal_swap_reset()
if global.blurafterimage
	scr_drawtexture(sprite_index, floor(image_index), x, y, image_xscale,
	image_yscale, image_angle, image_blend, image_alpha, tex,,,,spr_snicktexture)