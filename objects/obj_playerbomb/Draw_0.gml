if instance_exists(player) && REMIX_GAMEPLAY
	pal_swap_set(player.spr_palette, player.paletteselect, false);
draw_self();
pal_swap_reset();
