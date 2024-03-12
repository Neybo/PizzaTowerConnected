//Draw
if sprite_index == obj_player.spr_portalenter
{
	with obj_player
	{
		var pal = spr_peppalette
		var defpal = 1
		var pal_to_use = defpal
		if character == "P" || spr_portalenter != spr_pizzaportalend
		{
			pal = spr_palette
			pal_to_use = paletteselect
		}
		pal_swap_set(pal, pal_to_use, false)
	}
}	
	
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
pal_swap_reset()
scr_drawtexture(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha,,,,,spr_snicktexture)