// draw
if sprite_index == spr_yousuck
	pal_swap_set(spr_peppalette, clamp(obj_player.paletteselect, 1, pal_swap_get_pal_count(spr_peppalette) - 1), false)
else
	pal_swap_set(obj_player.spr_palette, obj_player.paletteselect, false)
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 
image_angle, image_blend, image_alpha);
shader_reset()
scr_drawtexture(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, 
image_blend, image_alpha, global.texturelist[global.playertexture], 960, 540, 1)
// sugary
if global.newpizzy && (obj_player.character == "SP" || obj_player.character == "SN") 
&& ended == 1 && alarm[1] == 0 
{
	draw_sprite(spr_sugaryclipboard, image_index, 650, suy)
}

// the text
if global.modifier != -1
{
	if image_index >= image_number - 1
		draw_sprite_ext(spr_rank_passed, -1, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
}
else if global.rank == "eggplant"
{
	if image_index >= image_number - 1
		draw_sprite_ext(spr_rankEGGPLANT, -1, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
}
else
{
	if asset_get_type(sprite_get_name(sprite_index) + "_text") == asset_sprite && sprite_index != spr_rankP
		draw_sprite_ext(asset_get_index(sprite_get_name(sprite_index) + "_text"), image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
}