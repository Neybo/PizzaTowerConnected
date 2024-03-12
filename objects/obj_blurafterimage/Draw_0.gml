if instance_exists(playerid)
{
	pal_swap_set(playerid.spr_palette, playerid.paletteselect, false);
	//if (playerid.character == "PUFFER") // better!
	//	sprite_index = spr_pufferfish_move
	image_angle = playerid.img_angle
}
draw_self();
if global.blurafterimage && instance_exists(playerid)
	scr_drawtexture(sprite_index, image_index, x, y, image_xscale,
	image_yscale, image_angle, image_blend, max(image_alpha * 2, 0.7), tex)
pal_swap_reset();