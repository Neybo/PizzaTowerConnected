draw_sprite_ext(sprite_index, -1, x + random_range(-collect_shake, collect_shake), y + random_range(-collect_shake, collect_shake), image_xscale, image_yscale, image_angle, image_blend, image_alpha);
if sprite_index == spr_weaponmachine_re && image_index < 7
{
	draw_set_font(global.smallnumber);
	draw_set_colour(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_text(x - 30, y - 26, string(price));
}

