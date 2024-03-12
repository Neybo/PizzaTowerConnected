var _spr = sprite_index;
if _spr == spr_swordstone && obj_player.character == "SP"
	_spr = spr_spoonstone;

draw_sprite_ext(_spr, -1, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);

