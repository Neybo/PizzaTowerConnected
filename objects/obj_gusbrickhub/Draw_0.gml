/// @description pal
if obj_player.character == "P"
	pal_swap_set(spr_peppalette, obj_player.paletteselect, 0)
else
	pal_swap_set(spr_peppalette, 1, 0)
draw_self()
pal_swap_reset()










