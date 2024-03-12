if spr == spr_gustavo_exitsign && !stick
{
	if obj_player.character == "P"
		pal_swap_set(obj_player.spr_palette, obj_player.paletteselect, false)
	else
		pal_swap_set(spr_peppalette, 1, false)
}
draw_self()
if (shader_current() != -1) 
{
	pal_swap_reset()
	scr_drawtexture(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, 
	image_blend, image_alpha,,,,,spr_gustavotexture)
}