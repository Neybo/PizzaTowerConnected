draw_set_colour(c_black);
draw_set_alpha(0.5);
draw_rectangle(0, 0, 960, 540, false);

draw_set_alpha(1);
draw_set_colour(c_white);
draw_set_halign(fa_left);
draw_set_font(global.bigfont);

/*
draw_text_auto(16 + random_range(-1, 1), 16, "MODIFIERS",,,sel[0] == 0 ? 1 : 0.5);
draw_text_auto(16 + random_range(-1, 1) + 960 / 2, 16, "MINIGAMES",,,sel[0] == 1 ? 1 : 0.5);
*/

draw_set_font(global.font_small);
for(var i = 0; i < array_length(choices); i++)
{
	var xx = 32 + lerp(0, 960, i / array_length(choices));
	for(var j = 0; j < array_length(choices[i]); j++)
	{
		draw_set_colour(c_white);
		if i == 0 && global.modifier == choices[i][j][0]
			draw_set_colour(merge_colour(c_lime, c_white, 0.5));
		draw_text_auto(xx, 32 + 16 * j, choices[i][j][1],,,sel[0] == i && sel[1] == j ? 1 : 0.5);
	}
}

