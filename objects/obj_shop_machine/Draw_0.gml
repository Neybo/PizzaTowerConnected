//Draw Text
draw_set_halign(fa_center);
draw_set_color(c_white)
draw_self()

// actually draw
if drawing
{
	draw_set_font(global.bigfont)
	
	draw_text(x, y + -50 + offset, string(price))
}

