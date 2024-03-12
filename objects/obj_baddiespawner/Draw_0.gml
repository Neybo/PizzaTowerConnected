draw_self();
if content == noone or !is_real(content) && !object_exists(content)
{
	draw_set_font(global.font_small);
	draw_set_colour(c_white);
	draw_text(x, y - 42 + (sin(current_time / 500) * 5), "?");
}

