function draw_text_auto(x, y, str, sep = undefined, w = undefined, alpha = draw_get_alpha())
{
	str = string(str);
	
	var font = draw_get_font()
	if font == global.sugarybigfont
	or font == global.smallfont or font == global.sugarysmallfont
	or (font == global.bigfont and !global.fontstyle)
		str = string_upper(str);
	
	var aprev = draw_get_alpha();
	draw_set_alpha(alpha);
	
	if is_undefined(sep) || is_undefined(w)
		draw_text(x, y, str);
	else
		draw_text_ext(x, y, str, sep, w);
	
	draw_set_alpha(aprev);
}

