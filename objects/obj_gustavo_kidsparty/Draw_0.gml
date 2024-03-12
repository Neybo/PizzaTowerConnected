if !stick
	pal_swap_set(obj_player.spr_palette, obj_player.paletteselect, 0)
draw_self()
if !stick
	pal_swap_reset()
